import 'package:multiple_result/multiple_result.dart';
import 'package:revolvair/domain/entities/auth/credentials.dart';
import 'package:revolvair/domain/entities/auth/login_user_dto.dart';
import 'package:revolvair/domain/failures/failure.dart';
import 'package:revolvair/domain/services/auth/auth_service.dart';

class PostLoginUsecase {
  final AuthService authService;
  PostLoginUsecase({required this.authService});

  Future<Result<LoginUserDto, Failure>> execute(Credentials creds) {
    return authService.login(creds);
  }
}
