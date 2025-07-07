import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/core/routes/app_router.dart';

import 'package:get/get.dart';

class AuthController extends GetxController {
  void goToRegisterScreen(UserRole userRole) {
    Get.toNamed(AppRoutes.registerScreen, arguments: userRole);
  }
}
