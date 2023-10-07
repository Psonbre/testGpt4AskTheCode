import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_result/src/result.dart';
import 'dart:convert' as convert;
import 'package:revolvair/data/api_routes.dart';
import 'package:revolvair/domain/entities/station.dart';
import 'package:revolvair/domain/failures/bad_request_failure.dart';
import 'package:revolvair/domain/failures/failure.dart';
import 'package:revolvair/domain/failures/server_failure.dart';
import 'package:revolvair/domain/services/station_service.dart';

class StationServiceImpl extends StationService {
  late final http.Client httpClient;
  final apiHost = dotenv.get('API_HOST');
  final apiPath = dotenv.get('API_PATH');

  StationServiceImpl({required this.httpClient});

  @override
  Future<Result<List<Station>, Failure>> getAllStations() async {
    try {
      var response =
          await httpClient.get(Uri.https(apiHost, "$apiPath$stations"));
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];

        List<Station> stationsList =
            data.map((entry) => Station.fromJson(entry)).toList();

        return Success(stationsList);
      } else if (response.statusCode == 400) {
        return Error(
            BadRequestFailure(context: "Bad Request : ${response.statusCode}"));
      } else {
        return Error(ServerFailure(
            context: "Unexpected status code: ${response.statusCode}"));
      }
    } on SocketException {
      return Error(
          ServerFailure(context: "There's been an error with the server"));
    } catch (e) {
      return Error(BadRequestFailure(context: "There's been an error: $e"));
    }
  }
}
