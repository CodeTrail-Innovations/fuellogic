import 'package:fuellogic/modules/auth/screens/auth_screen.dart';
import 'package:fuellogic/modules/auth/screens/login_screen.dart';
import 'package:fuellogic/modules/auth/screens/register_screen.dart';
import 'package:fuellogic/modules/auth/screens/splash_screen.dart';
import 'package:fuellogic/modules/welcome/screen/welcome_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class AppRoutes {
  static const splashScreen = "/splashScreen";
  static const loginScreen = "/loginScreen";
  static const registerScreen = "/registerScreen";
  static const authScreen = "/authScreen";
  static const welcomeScreen = "/welcomeScreen";

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
    GetPage(
      name: authScreen,
      page: () => AuthScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: welcomeScreen,
      page: () => WelcomeScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
