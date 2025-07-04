import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/auth/models/user_model.dart';
import 'package:fuellogic/modules/orders/models/order_model.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final Rx<UserModel?> userData = Rx<UserModel?>(null);
  final RxList<OrderModel> ordersList = <OrderModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchCurrentUserData();
    fetchCurrentUserOrders();
    super.onInit();
  }

  int get deliveredOrdersCount =>
      ordersList
          .where((order) => order.orderStatus == OrderStatus.delivered)
          .length;

  int get onTheWayOrdersCount =>
      ordersList
          .where((order) => order.orderStatus == OrderStatus.onTheWay)
          .length;

  Future<void> fetchCurrentUserData() async {
    try {
      isLoading.value = true;
      final user = auth.currentUser;
      if (user != null) {
        final userDoc = await firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          final userData = userDoc.data();
          if (userData != null) {
            this.userData.value = UserModel.fromJson(userData);
          }
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

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
                .map((doc) => OrderModel.fromMap(doc.data()))
                .toList();

        ordersList.assignAll(fetchedOrders);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load orders: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
