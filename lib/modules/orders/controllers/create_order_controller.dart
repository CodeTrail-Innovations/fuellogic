import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/orders/models/create_order_modeL.dart';
import 'package:get/get.dart';

class CreateOrderController extends GetxController {
  final locationController = TextEditingController();
  final quantityController = TextEditingController();
  final dateController = TextEditingController();
  final fuelType = FuelType.gaseous.obs;
  final fuelUnit = FuelUnit.liters.obs;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
      );

      await _firebaseFirestore
          .collection('orders')
          .doc(order.id)
          .set(order.toMap());

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
