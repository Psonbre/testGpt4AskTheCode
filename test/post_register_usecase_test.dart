import 'package:mocktail/mocktail.dart';
import 'package:revolvair/domain/usecases/auth/post_register_usecase.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:revolvair/domain/entities/auth/login_user_dto.dart';
import 'package:revolvair/domain/entities/registeringUserDto.dart';
import 'package:revolvair/domain/failures/failure.dart';
import 'package:revolvair/domain/services/auth/auth_service.dart';

// Mock AuthService
class MockAuthService extends Mock implements AuthService {}

void main() {
  group('PostRegisterUsecase Tests', () {
    late PostRegisterUsecase postRegisterUsecase;
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
      postRegisterUsecase = PostRegisterUsecase(authService: mockAuthService);
    });

    test('execute - successful registration', () async {
      // Arrange
      final registeringUserDto = RegisteringUserDto(name: 'test1', email: 'test2', password: 'test3');
      final loginUserDto = LoginUserDto();

      when(mockAuthService.signup(registeringUserDto) as Function())
          .thenAnswer((_) async => Success(loginUserDto));

      // Act
      final result = await postRegisterUsecase.execute(registeringUserDto);

      // Assert
      result.when((success) => expect(true, true), (error) => throw const Error("Shouldn't happen"));
    });

    test('execute - registration failure', () async {
      // Arrange
      final registeringUserDto = RegisteringUserDto(/* your parameters here */);
      final failure = Failure(/* your failure parameters here */);

      when(mockAuthService.signup(registeringUserDto) as Function())
          .thenAnswer((_) async => FailureResult(failure));

      // Act
      final result = await postRegisterUsecase.execute(registeringUserDto);

      // Assert
      result.when((error) => expect(true, true), (success) => throw const Error("Shouldn't happen"));
    });
  });
}
