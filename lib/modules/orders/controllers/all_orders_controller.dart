import 'package:get/get.dart';

class AllOrdersController extends GetxController {
  int selectedIndex = 0;
  List<String> orderFilter = [
    "All",
    "Pending",
    "Accepted",
    "On the way",
    "Delivered",
  ];

  void selectText(int index) {
    selectedIndex = index;
    update();
  }
}
