import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/auth/models/user_model.dart';
import 'package:fuellogic/modules/orders/models/order_model.dart';
import 'package:get/get.dart';

class CreateOrderController extends GetxController {
  final locationController = TextEditingController();
  final quantityController = TextEditingController();
  final dateController = TextEditingController();
  final fuelType = FuelType.gaseous.obs;
  final fuelUnit = FuelUnit.liters.obs;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Rx<UserModel?> userData = Rx<UserModel?>(null);
  @override
  void onInit() {
    fetchCurrentUserData();
    super.onInit();
  }

  Future<void> fetchCurrentUserData() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final userDoc =
            await _firebaseFirestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          final userData = userDoc.data();
          if (userData != null) {
            this.userData.value = UserModel.fromJson(userData);
          }
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data: $e');
    } finally {}
  }

  Future<void> createOrder() async {
    try {
      if (locationController.text.isEmpty ||
          quantityController.text.isEmpty ||
          dateController.text.isEmpty) {
        Get.snackbar("Error", "Please fill all fields");
        return;
      }

      final order = OrderModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        location: locationController.text,
        fuelType: fuelType.value,
        quantity: quantityController.text,
        fuelUnit: fuelUnit.value,
        date: dateController.text,
        orderStatus: OrderStatus.pending,
        companyId: userData.value!.companyId,
        driverId: _firebaseAuth.currentUser!.uid,
        driverName: userData.value!.displayName,
      );

      await _firebaseFirestore
          .collection('orders')
          .doc(order.id)
          .set(order.toJson());

      Get.snackbar(
        'Success',
        'Order created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create order: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    locationController.dispose();
    quantityController.dispose();
    dateController.dispose();
    super.onClose();
  }
}
