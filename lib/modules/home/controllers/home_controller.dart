import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/orders/models/order_model.dart';
import 'package:get/get.dart';

import '../../company/repositories/company_repository.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  /// The raw, unfiltered list bound directly to Firestore's live stream
  final allOrders = <OrderModel>[].obs;

  /// The list we actually show in the UI after search/filters
  final orders    = <OrderModel>[].obs;
  var isLoading = true.obs;
  final _companyRepository = CompanyRepository();

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
    // fetchOrders();


    allOrders.bindStream(_companyRepository.getOrders());


    super.onInit();
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


}
