import 'package:fuellogic/core/enums/user_role.dart';
import 'package:fuellogic/core/routes/app_router.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  void goToRegisterScreen(UserRole userRole) {
    Get.toNamed(AppRouter.registerScreen, arguments: userRole);
  }
}
