import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:multiple_result/src/result.dart';
import 'package:revolvair/data/api_routes.dart';
import 'package:revolvair/domain/entities/ranges.dart';
import 'package:revolvair/domain/failures/bad_request_failure.dart';
import 'package:revolvair/domain/failures/failure.dart';
import 'package:revolvair/domain/failures/server_failure.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:convert' as convert;

import 'package:revolvair/domain/services/ranges_service.dart';

class RangesServiceImpl extends RangesService {
  late final http.Client httpClient;
  final apiHost = dotenv.get('API_HOST');
  final apiPath = dotenv.get('API_PATH');

  RangesServiceImpl({required this.httpClient});

  Future<Result<Ranges, Failure>> executeRequest({required Uri url}) async {
    try {
      var response = await httpClient.get(url);
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return Success(Ranges.fromJson(jsonResponse));
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

  @override
  Future<Result<Ranges, Failure>> getAquiAirQualityRanges() {
    var url = Uri.https(apiHost, "$apiPath$aqiAQHI");
    return executeRequest(url: url);
  }

  @override
  Future<Result<Ranges, Failure>> getUsepaAirQualityRanges() {
    var url = Uri.https(apiHost, "$apiPath$aqiUSEPA");
    return executeRequest(url: url);
  }

  @override
  Future<Result<Ranges, Failure>> getRevolvairAirQualityRanges() async {
    var url = Uri.https(apiHost, "$apiPath$aqiRevolvair");
    return executeRequest(url: url);
  }
}
