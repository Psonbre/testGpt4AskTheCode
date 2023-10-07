import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:revolvair/data/api_routes.dart';
import 'package:revolvair/data/api_station_service_impl.dart';
import 'package:revolvair/domain/failures/bad_request_failure.dart';
import 'package:revolvair/domain/failures/server_failure.dart';
import 'package:revolvair/domain/usecases/get_station_usecase.dart';

import 'helpers/fixture.dart';

class MockHttp extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() async {
  await dotenv.load(fileName: "./lib/.env");
  late StationServiceImpl apiRestServiceImpl;
  late GetStationUseCase getStationUseCase;
  late http.Client mockHttpClient;
  late String apiHost;
  late String apiPath;

  setUp(() {
    registerFallbackValue(FakeUri());
    mockHttpClient = MockHttp();
    apiRestServiceImpl = StationServiceImpl(httpClient: mockHttpClient);
    getStationUseCase = GetStationUseCase(stationService: apiRestServiceImpl);
    apiHost = dotenv.get('API_HOST');
    apiPath = dotenv.get('API_PATH');
  });

  group('GetStationUsecase', () {
    group('Les stations sont retournées avec succès', () {
      test('Succès, retourne 200', () async {
        final expectedStation = Fixture.createStation(file: "stations.json");
        final httpResponse =
            Fixture.createHttpResponse(file: 'stations.json', code: 200);
        when(() => mockHttpClient.get(Uri.https(apiHost, '$apiPath$stations')))
            .thenAnswer((_) async => httpResponse);
        var result = await getStationUseCase.execute();

        expect(result.tryGetSuccess(), expectedStation);
      });
    });
    group('Les stations ne sont pas retournées', () {
      test('Une erreur BadRequest est lancee quand l\'url n\'existe pas',
          () async {
        when(() => mockHttpClient.get(any())).thenThrow(Exception('oops'));

        var result = await getStationUseCase.execute();

        expect(result.tryGetError(), isA<BadRequestFailure>());
      });
      test('Une erreur ServerFailure est lancee quand un status code inconnu est retourne(500)',
          () async {
        when(() => mockHttpClient.get(any()))
            .thenThrow(const SocketException("Server indisponible"));
        var result = await getStationUseCase.execute();

        expect(result.tryGetError(), isA<ServerFailure>());
      });
    });
  });
}
