import 'package:fuellogic/modules/auth/screens/login_screen.dart';
import 'package:fuellogic/modules/auth/screens/register_screen.dart';
import 'package:fuellogic/modules/auth/screens/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRouter {
  static const splashScreen = "/splashScreen";
  static const loginScreen = "/loginScreen";
  static const registerScreen = "/registerScreen";
  static final routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: registerScreen, page: () => RegisterScreen()),
  ];
}
