import 'package:multiple_result/multiple_result.dart';
import 'package:revolvair/domain/entities/auth/credentials.dart';
import 'package:revolvair/domain/entities/auth/login_user_dto.dart';
import 'package:revolvair/domain/failures/failure.dart';
import 'package:revolvair/domain/usecases/auth/post_login_usecase.dart';
import 'package:revolvair/presentation/app/app.router.dart';
import 'package:revolvair/presentation/app/app_setup.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final String logo =
      "https://revolvair.org/wp-content/uploads/2020/11/cropped-revolvair-logo-texte.jpg";
  final PostLoginUsecase postLoginUsecase = locator<PostLoginUsecase>();
  final dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  LoginUserDto? login;

  navigateToRegistrationPage() async {
    await _navigationService.navigateTo(Routes.registrationView);
  }

  Future<void> submit(String email, String password) async {
    setBusy(true);
    Credentials credentials = Credentials(email: email, password: password);
    Result<LoginUserDto, Failure> result =
        await postLoginUsecase.execute(credentials);
    result.when(
      (success) async {
        await dialogService.showDialog(
            title: 'Success',
            description: "Connexion reussi",
            buttonTitle: 'OK');
      },
      (error) async {
        await dialogService.showDialog(
            title: 'Echec', description: 'Connexion echoue', buttonTitle: 'OK');
      },
    );

    setBusy(false);
  }

  navigateToRegistrationView() async {
    await _navigationService.navigateTo(Routes.registrationView);
  }
}
