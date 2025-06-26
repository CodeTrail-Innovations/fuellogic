import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuellogic/config/theme.dart';
import 'package:fuellogic/core/routes/app_router.dart';
import 'package:fuellogic/modules/auth/screens/register_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      getPages: AppRouter.routes,
      // initialRoute: AppRouter.splashScreen,
      home: RegisterScreen(),
    );
  }
}
