import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:revolvair/data/api_ranges_service_impl.dart';
import 'package:revolvair/domain/failures/bad_request_failure.dart';
import 'package:revolvair/domain/failures/server_failure.dart';
import 'package:revolvair/domain/usecases/AQI.dart';
import 'package:revolvair/domain/usecases/get_revolvair_aqi_usecase.dart';
import 'package:test/test.dart';
import 'package:revolvair/data/api_routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'helpers/fixture.dart';

class MockHttp extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() async {
  await dotenv.load(fileName: "./lib/.env");
  late RangesServiceImpl apiRestServiceImpl;
  late GetRangesUseCase getRangesUseCase;
  late http.Client mockHttpClient;
  late String apiHost;
  late String apiPath;

  setUp(() {
    registerFallbackValue(FakeUri());
    mockHttpClient = MockHttp();
    apiRestServiceImpl = RangesServiceImpl(httpClient: mockHttpClient);
    getRangesUseCase = GetRangesUseCase(rangesService: apiRestServiceImpl);
    apiHost = dotenv.get('API_HOST');
    apiPath = dotenv.get('API_PATH');
  });

  group('Air Quality Index', () {
    group('Revolvair', () {
      test('Les informations de l\'object Ranges Revolvair sont retournées',
          () async {
        final expectedRanges = Fixture.createRanges(file: "ranges.json");
        final httpResponse =
            Fixture.createHttpResponse(file: 'ranges.json', code: 200);
        when(() =>
                mockHttpClient.get(Uri.https(apiHost, '$apiPath$aqiRevolvair')))
            .thenAnswer((_) async => httpResponse);
        var result = await getRangesUseCase.execute(AQI.revolvair);

        expect(result.tryGetSuccess(), expectedRanges);
      });
      test('Une erreur BadRequest est lancee quand l\'url n\'existe pas',
          () async {
        when(() => mockHttpClient.get(any())).thenThrow(Exception('oops'));

        var result = await getRangesUseCase.execute(AQI.revolvair);

        expect(result.tryGetError(), isA<BadRequestFailure>());
      });
      test(
          'Une erreur ServerFailure est lancee quand un status code inconnu est retourne(500)',
          () async {
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => http.Response(json.encode([]), 500));
        var result = await getRangesUseCase.execute(AQI.revolvair);

        expect(result.tryGetError(), isA<ServerFailure>());
      });
    });
    group('AQHI', () {
      test('Les informations de l\'object Ranges AQHI sont retournées',
          () async {
        final expectedRanges = Fixture.createRanges(file: "ranges.json");
        final httpResponse =
            Fixture.createHttpResponse(file: 'ranges.json', code: 200);
        when(() =>
                mockHttpClient.get(Uri.https(apiHost, '$apiPath$aqiAQHI')))
            .thenAnswer((_) async => httpResponse);
        var result = await getRangesUseCase.execute(AQI.aqhi);

        expect(result.tryGetSuccess(), expectedRanges);
      });
      test('Une erreur BadRequest est lancee quand l\'url n\'existe pas',
          () async {
        when(() => mockHttpClient.get(any())).thenThrow(Exception('oops'));

        var result = await getRangesUseCase.execute(AQI.aqhi);

        expect(result.tryGetError(), isA<BadRequestFailure>());
      });
      test(
          'Une erreur ServerFailure est lancee quand un status code inconnu est retourne(500)',
          () async {
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => http.Response(json.encode([]), 500));
        var result = await getRangesUseCase.execute(AQI.aqhi);

        expect(result.tryGetError(), isA<ServerFailure>());
      });
    });
    group('USEPA', () {
      test('Les informations de l\'object Ranges USEPA sont retournées',
          () async {
        final expectedRanges = Fixture.createRanges(file: "ranges.json");
        final httpResponse =
            Fixture.createHttpResponse(file: 'ranges.json', code: 200);
        when(() =>
                mockHttpClient.get(Uri.https(apiHost, '$apiPath$aqiUSEPA')))
            .thenAnswer((_) async => httpResponse);
        var result = await getRangesUseCase.execute(AQI.usepa);

        expect(result.tryGetSuccess(), expectedRanges);
      });
      test('Une erreur BadRequest est lancee quand l\'url n\'existe pas',
          () async {
        when(() => mockHttpClient.get(any())).thenThrow(Exception('oops'));

        var result = await getRangesUseCase.execute(AQI.usepa);

        expect(result.tryGetError(), isA<BadRequestFailure>());
      });
      test(
          'Une erreur ServerFailure est lancee quand un status code inconnu est retourne(500)',
          () async {
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => http.Response(json.encode([]), 500));
        var result = await getRangesUseCase.execute(AQI.usepa);

        expect(result.tryGetError(), isA<ServerFailure>());
      });
    });
  });
}
