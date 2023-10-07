import 'package:flutter/material.dart';
import 'package:revolvair/presentation/app/app.router.dart';
import 'package:revolvair/presentation/app/app_setup.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: "./lib/.env");
  WidgetsFlutterBinding.ensureInitialized();
  await AppSetup.setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.homeView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
    );
  }
}
