import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_result/multiple_result.dart';
import 'package:revolvair/domain/entities/auth/login_user_dto.dart';
import 'package:revolvair/domain/entities/registeringUserDto.dart';
import 'package:revolvair/domain/failures/failure.dart';
import 'package:revolvair/domain/usecases/auth/post_register_usecase.dart';
import 'package:revolvair/presentation/app/app.router.dart';
import 'package:revolvair/presentation/app/app_setup.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final revolvairLogoUrl = "https://revolvair.org/wp-content/uploads/2020/11/cropped-revolvair-logo-texte.jpg";
  final revolvairTOSUrl = "https://staging.revolvair.org/assets/tos.html";
  final http.Client httpClient = http.Client();
  final postRegisterUsecase = locator<PostRegisterUsecase>();
  final dialogService = locator<DialogService>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  launchTOS() async {
    Uri url = Uri.parse(revolvairTOSUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> registerUser() async {
    setBusy(true);
    RegisteringUserDto credentials = RegisteringUserDto(name: nameController.text, email: emailController.text, password: passwordController.text);
    Result<LoginUserDto, Failure> result =
        await postRegisterUsecase.execute(credentials);
    result.when(
      (success) => navigateToHomeView(),
      (error) async {
        await dialogService.showDialog(
            title: error.context, description: error.message, buttonTitle: 'OK');
      },
    );

    setBusy(false);
  }

  navigateToHomeView() async {
    await _navigationService.navigateTo(Routes.homeView);
  }
}
