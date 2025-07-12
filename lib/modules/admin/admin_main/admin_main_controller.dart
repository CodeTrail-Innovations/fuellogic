import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuellogic/modules/admin/admin_main/admin_orders_repo.dart';
import 'package:get/get.dart';

import '../../../core/enums/enum.dart';
import '../../../core/routes/app_router.dart';
import '../../../helper/utils/hive_utils.dart';
import '../../orders/models/order_model.dart';

class AdminMainController extends GetxController {
  final repo = AdminOrdersRepository();
  final FirebaseAuth auth = FirebaseAuth.instance;


  final orders     = <OrderModel>[].obs;
  // var isLoading = true.obs;

  var selectedIndex = 0.obs;

  List<String> orderFilter = [
    "All",
    "Pending",
    "Accepted",
    "On the way",
    "Delivered",
  ];

  @override
  void onInit() {
    super.onInit();
    repo.getOrders()
        .listen((list) {
      orders.assignAll(list);
    });

  }


  List<OrderModel> get filteredOrders {
    if (selectedIndex.value == 0) return orders;

    switch (orderFilter[selectedIndex.value]) {
      case "Pending":
        return orders
            .where((order) => order.orderStatus == OrderStatus.pending)
            .toList();
      case "Accepted":
        return orders
            .where((order) => order.orderStatus == OrderStatus.approved)
            .toList();
      case "On the way":
        return orders
            .where((order) => order.orderStatus == OrderStatus.onTheWay)
            .toList();
      case "Delivered":
        return orders
            .where((order) => order.orderStatus == OrderStatus.delivered)
            .toList();
      default:
        return orders;
    }
  }

  void selectFilter(int index) {
    selectedIndex.value = index;
    log('Filter selected: ${orderFilter[index]}');
  }




    void logout() async {
      try {
        await auth.signOut();
        HiveBox().clearAppSession();
        Get.offAllNamed(AppRoutes.welcomeScreen);
      } catch (e) {
        log('Error logging out: $e');
      }
    }




}