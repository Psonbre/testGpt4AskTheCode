import 'package:multiple_result/multiple_result.dart';
import 'package:revolvair/domain/entities/auth/credentials.dart';
import 'package:revolvair/domain/entities/auth/login_user_dto.dart';
import 'package:revolvair/domain/entities/registeringUserDto.dart';
import 'package:revolvair/domain/failures/failure.dart';

abstract class AuthService {
  Future<Result<LoginUserDto, Failure>> login(Credentials creds);
  Future<Result<Success, Failure>> logout();
  Future<Result<LoginUserDto, Failure>> signup(RegisteringUserDto userInfo);
}
