import 'package:get/get.dart';

class WelcomeController extends GetxController {
  /// 0 = Home, 1 = Orders
  final selectedTab = 0.obs;

  void selectTab(int index) {
    selectedTab.value = index;
  }
}