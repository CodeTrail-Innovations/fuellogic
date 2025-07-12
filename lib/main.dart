import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuellogic/config/theme.dart';
import 'package:fuellogic/core/routes/app_router.dart';
import 'package:fuellogic/helper/utils/hive_utils.dart';
import 'package:get/get.dart';

import 'package:googleapis_auth/auth_io.dart';

import 'firebase_options.dart';
import 'helper/services/fcm_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  HiveBox().openBoxes();
  final jsonStr = await rootBundle.loadString('assets/jsons/service-account.json');
  final jsonMap = jsonDecode(jsonStr) as Map<String, dynamic>;

  final creds = ServiceAccountCredentials.fromJson(jsonMap);
  final projectId = jsonMap['project_id'] as String;
  final fcmService = FcmService(creds, projectId);

// Register it with GetX
  Get.put<FcmService>(fcmService);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Message ${message.notification!.title.toString()}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      getPages: AppRoutes.routes,
      initialRoute: AppRoutes.splashScreen,
      // home: WelcomeScreen(),
    );
  }
}
