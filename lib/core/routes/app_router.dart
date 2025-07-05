import 'package:fuellogic/modules/auth/screens/login_screen.dart';
import 'package:fuellogic/modules/auth/screens/register_screen.dart';
import 'package:fuellogic/modules/auth/screens/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class AppRouter {
  static const splashScreen = "/splashScreen";
  static const loginScreen = "/loginScreen";
  static const registerScreen = "/registerScreen";
   static final routes = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: registerScreen,
      page: () => RegisterScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
