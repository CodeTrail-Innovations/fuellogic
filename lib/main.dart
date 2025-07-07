import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuellogic/config/theme.dart';
import 'package:fuellogic/core/routes/app_router.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'helper/services/auth_service.dart';
import 'helper/theme/app_theme.dart';
import 'modules/auth/controllers/auth_controller.dart';
import 'modules/auth/screens/splash_screen.dart';


final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  final prefs = await SharedPreferences.getInstance();
  Get.put(prefs);
  Get.put(AuthService());
  Get.put(AuthController());
  Get.put<SharedPreferences>(prefs);
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> globalNavigator = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      title: 'Fuelogic',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[routeObserver],
      navigatorKey: Get.key,
      initialRoute: AppRoutes.splashScreen,
      getPages: AppRoutes.routes,
      home: const SplashScreen(),
      // initialBinding: AppBinding(),

    );
    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: appTheme,
    //   getPages: AppRoutes.routes,
    //   initialRoute: AppRoutes.splashScreen,
    //   // home: DashboardScreen(),
    // );
  }
}
