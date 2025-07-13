import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/helper/constants/keys.dart';
import 'package:fuellogic/helper/utils/hive_utils.dart';
import 'package:fuellogic/modules/orders/models/order_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../company/repositories/company_repository.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final RxList<OrderModel> orders = <OrderModel>[].obs;
  // final orders     = <OrderModel>[].obs;
  var isLoading = true.obs;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final companyOrderRepo = CompanyOrdersRepository();

  var selectedIndex = 0.obs;
  final role = HiveBox().getValue(key: roleKey);

  List<String> orderFilter = [
    "All",
    "Pending",
    "Accepted",
    "On the way",
    "Delivered",
  ];

  @override
  void onInit() {
    fetchOrders();
    // final roleId = role == companyRoleKey ? 'companyId' : 'driverId';
    // final user = _firebaseAuth.currentUser;
    // final userId = user?.uid;
    // if (user != null) {
    //   companyOrderRepo.getDriverOrders(userId ?? '')
    //       .listen((list) {
    //     orders.assignAll(list);
    //   });
    //
    // }

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

  Future<void> fetchOrders() async {
    try {
      log('Fetching orders...');
      isLoading(true);

      final roleId = role == companyRoleKey ? 'companyId' : 'driverId';
      final user = _firebaseAuth.currentUser;
      final userId = user?.uid;

      _firebaseFirestore
          .collection('orders')
      .where(roleId, isEqualTo: userId)
      .orderBy('createdAt', descending: true)
          .snapshots()
          .listen(
            (snapshot) {
              log('Received snapshot with ${snapshot.docs.length} documents');

              if (snapshot.docs.isEmpty) {
                log('No documents found in orders collection');
                orders.clear();
                isLoading(false);
                return;
              }

              final fetchedOrders = <OrderModel>[];

              for (var doc in snapshot.docs) {
                try {
                  log('Processing doc: ${doc.id} with data: ${doc.data()}');
                  final order = OrderModel.fromJson(doc.data());
                  fetchedOrders.add(order);
                  log('Successfully parsed order: ${order.toString()}');
                } catch (e) {
                  log('Error parsing document ${doc.id}: $e');
                  log('Document data: ${doc.data()}');
                }
              }

              orders.assignAll(fetchedOrders);
              isLoading(false);
              log('Orders assigned: ${orders.length}');
            },
            onError: (error) {
              log('Error in Firestore snapshot listener: $error');
              isLoading(false);
              Get.snackbar("Error", "Failed to fetch orders: $error",snackPosition: SnackPosition.BOTTOM);
            },
          );
    } catch (e, stack) {
      log('Exception in fetchOrders: $e\n$stack');
      isLoading(false);
      Get.snackbar("Error", "Failed to fetch orders: $e",snackPosition: SnackPosition.BOTTOM);
    }
  }

  void selectFilter(int index) {
    selectedIndex.value = index;
    log('Filter selected: ${orderFilter[index]}');
  }

  Future<void> refreshOrders() async {
    await fetchOrders();
  }
}
