import 'package:fuellogic/modules/auth/screens/login_screen.dart';
import 'package:fuellogic/modules/auth/screens/register_screen.dart';
import 'package:fuellogic/modules/auth/screens/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class AppRoutes {
  static const splashScreen = "/splashScreen";
  static const loginScreen = "/loginScreen";
  static const registerScreen = "/registerScreen";

  static const String home = '/home';

  static const String addOrderScreen = '/orders/add-order';
  static const String allOrders = '/orders/all';
  static const String orderDetails = '/orders/details';
  static const String customerOrders = '/customer/orders';

  static const String adminMainScreen = '/admin/main-screen';
  static const String userMainScreen = '/user/main-screen';

  static const String itemDetailsScreen = '/user/items/item-details';

  ///orders
  static const String userAddOrderScreen = '/user/orders/add-order-screen';
  static const String userOrderDetailsScreen = '/user/orders/order-details-screen';


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
