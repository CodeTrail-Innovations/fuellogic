import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/auth/models/user_model.dart';
import 'package:fuellogic/modules/orders/models/order_model.dart';
import 'package:get/get.dart';

class OrderHistoryController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final Rx<UserModel?> userData = Rx<UserModel?>(null);
  final RxList<OrderModel> ordersList = <OrderModel>[].obs;
  final Rx<OrderStatus?> selectedStatus = Rx<OrderStatus?>(null);
  final RxBool isLoading = false.obs;

  Future<void> fetchCurrentUserOrders() async {
    try {
      isLoading.value = true;

      final user = auth.currentUser;
      if (user != null) {
        final querySnapshot =
            await firestore
                .collection("orders")
                .where("companyId", isEqualTo: user.uid)
                .get();

        final fetchedOrders =
            querySnapshot.docs
                .map((doc) => OrderModel.fromJson(doc.data()))
                .toList();

        ordersList.assignAll(fetchedOrders);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load orders: $e',snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
