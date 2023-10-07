import 'package:revolvair/presentation/views/auth/login/login_view.dart';
import 'package:revolvair/presentation/views/home/home_view.dart';
import 'package:revolvair/presentation/views/auth/registration/registration_view.dart';
import 'package:revolvair/presentation/views/scale/scale_view.dart';
import 'package:revolvair/presentation/views/scale/tabs/range_infos_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: ScaleView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RangeInfoView),
    MaterialRoute(page: RegistrationView)
  ],
  )
class App {}