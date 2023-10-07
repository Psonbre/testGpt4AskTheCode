import 'dart:io';
import 'dart:convert' as convert;
import 'package:revolvair/data/api_routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_result/src/result.dart';
import 'package:revolvair/domain/entities/auth/credentials.dart';
import 'package:revolvair/domain/entities/auth/login_user_dto.dart';
import 'package:revolvair/domain/entities/registeringUserDto.dart';
import 'package:revolvair/domain/failures/bad_registration_failure.dart';
import 'package:revolvair/domain/failures/bad_request_failure.dart';
import 'package:revolvair/domain/failures/failure.dart';
import 'package:revolvair/domain/failures/server_failure.dart';
import 'package:revolvair/domain/services/auth/auth_service.dart';

class AuthServiceImpl extends AuthService {
  late final http.Client httpClient;
  final apiHost = dotenv.get('API_HOST');

  AuthServiceImpl({required this.httpClient});
  @override
  Future<Result<LoginUserDto, Failure>> login (Credentials creds) async {
    try{
      var response = await httpClient.post(Uri.https(apiHost, apiLogin), body: creds.toJson());
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return Success(LoginUserDto.fromJson(jsonResponse));
      } else if (response.statusCode == 400) {
        return Error(
            BadRequestFailure(context: "Bad Request : ${response.statusCode}"));
      } else {
        return Error(ServerFailure(
            context: "Unexpected status code: ${response.statusCode}"));
      }
    }on SocketException {
      return Error(
          ServerFailure(context: "There's been an error with the server"));
    } catch (e) {
      return Error(BadRequestFailure(context: "There's been an error: $e"));
    }
    
  }

  @override
  Future<Result<Success, Failure>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Result<LoginUserDto, Failure>> signup(RegisteringUserDto userInfo) async {
    try{
      var response = await httpClient.post(
        Uri.https(apiHost, apiRegister),
        headers: { HttpHeaders.acceptHeader : 'application/json'}, 
        body: userInfo.toJson(), 
      );

      if (response.statusCode == 201) {
        var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
        return Success(LoginUserDto.fromJson(jsonResponse));
      } else if (response.statusCode == 422) {
        final jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
        return Error(
            BadRegistrationFailure(context: jsonResponse['message'], message: jsonResponse['errors']['email'][0]));
      } else {
        return Error(ServerFailure(
            context: "Unexpected status code: ${response.statusCode}"));
      }
    }on SocketException {
      return Error(
          ServerFailure(context: "There's been an error with the server"));
    } catch (e) {
      return Error(BadRequestFailure(context: "There's been an error: $e"));
    }
  }
  
}

