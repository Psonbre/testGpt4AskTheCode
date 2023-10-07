import 'package:multiple_result/multiple_result.dart';
import 'package:revolvair/domain/entities/auth/login_user_dto.dart';
import 'package:revolvair/domain/entities/registeringUserDto.dart';
import 'package:revolvair/domain/failures/failure.dart';
import 'package:revolvair/domain/services/auth/auth_service.dart';

class PostRegisterUsecase {
  final AuthService authService;
  PostRegisterUsecase({required this.authService});

  Future<Result<LoginUserDto, Failure>> execute(RegisteringUserDto creds) {
    return authService.signup(creds);
  }
}
