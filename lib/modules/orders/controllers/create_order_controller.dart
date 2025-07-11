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
  final descriptionController = TextEditingController();
  final fuelType = FuelType.gaseous.obs;
  final fuelUnit = FuelUnit.liters.obs;
  final isLoading = false.obs;

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
    isLoading.value = true;
    try {
      if (locationController.text.isEmpty ||
          quantityController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          dateController.text.isEmpty) {
        Get.snackbar("Error", "Please fill all fields");
        return;
      }

      if (userData.value == null) {
        Get.snackbar("Error", "User data not available");
        return;
      }

      final currentUser = userData.value!;
      final order = OrderModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        location: locationController.text,
        description: descriptionController.text,
        quantity: quantityController.text,
        date: dateController.text,
        orderStatus: OrderStatus.pending,
        companyId: currentUser.companyId,
        // companyId: currentUser.uid,
        createdAt: DateTime.now(),
        driverId:
            currentUser.role == UserRole.company
                ? null
                : _firebaseAuth.currentUser?.uid,
        driverName:
            currentUser.role == UserRole.company
                ? null
                : currentUser.displayName,
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
      clearFields();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create order: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    locationController.dispose();
    quantityController.dispose();
    dateController.dispose();
    super.onClose();
  }

  void clearFields(){
    locationController.clear();
    descriptionController.clear();
    quantityController.clear();
    dateController.clear();
  }
}
