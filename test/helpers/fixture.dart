import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:revolvair/domain/entities/ranges.dart';
import 'package:revolvair/domain/entities/station.dart';

class Fixture {
  static Ranges createRanges({required String file}) {
    final jsonString = File('test/fixtures/$file').readAsStringSync();
    final Map<String, dynamic> rangesJson = json.decode(jsonString);
    return Ranges.fromJson(rangesJson);
  }

  static List<Station> createStation({required String file}) {
    final jsonString = File('test/fixtures/$file').readAsStringSync();
    final Map<String, dynamic> jsonResponse = json.decode(jsonString);
    final List<dynamic> data = jsonResponse['data'];

    return data.map((entry) => Station.fromJson(entry)).toList();
  }

  static http.Response createHttpResponse(
      {required String file, required int code}) {
    final jsonString = File('test/fixtures/$file').readAsStringSync();
    return http.Response(jsonString, code);
  }

  static http.Response createLoginUserDto(
      {required String file, required int code}) {
    final jsonString = File('test/fixtures/$file').readAsStringSync();
    return http.Response(jsonString, code);
  }
}
