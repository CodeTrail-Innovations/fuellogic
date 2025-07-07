import 'package:get/get.dart';

import '../../../core/routes/app_router.dart';
import '../../../data_manager/models/user_model.dart';
import '../../../helper/services/auth_service.dart';

class WelcomeController extends GetxController {
  /// 0 = Home, 1 = Orders
  final selectedTab = 0.obs;

  void selectTab(int index) {
    selectedTab.value = index;
  }

  Future<void> navigation() async {
    // await Future.delayed(Duration(seconds: 1));
    final authService = Get.find<AuthService>();
    await authService.loadSession();

    final user = await authService.getCurrentUser();
    if (user != null) {
      _navigateBasedOnRole(user);
    } else {
      Get.offAllNamed(AppRoutes.loginScreen);
    }
  }

  void _navigateBasedOnRole(UserModel user) {
    switch (user.role) {
      case 'admin':
        Get.offAllNamed(AppRoutes.adminMainScreen);
        break;
      case 'company':
        Get.offAllNamed(AppRoutes.companyMainScreen);
        break;
      default:
        Get.offAllNamed(AppRoutes.loginScreen);
        break;
    }
  }


}