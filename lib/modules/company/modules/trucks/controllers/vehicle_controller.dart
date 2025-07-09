import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuellogic/modules/auth/models/user_model.dart';
import 'package:fuellogic/modules/company/modules/trucks/models/vehicle_model.dart';
import 'package:get/get.dart';

class VehicleController extends GetxController {
  final vehicleNameController = TextEditingController();
  final vehicleNumberController = TextEditingController();
  final vehicleCapacityController = TextEditingController();
  final isLoading = false.obs;
  final vehicles = <VehicleModel>[].obs;

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
            
            await fetchVehicles();
          }
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data: $e');
    }
  }

  Future<void> fetchVehicles() async {
    try {
      isLoading.value = true;
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final querySnapshot = await _firebaseFirestore
            .collection('vehicles')
            .where('companyId', isEqualTo: user.uid)
            .get();

        vehicles.assignAll(
          querySnapshot.docs
              .map((doc) => VehicleModel.fromJson(doc.data()))
              .toList(),
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch vehicles: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createVehicle() async {
    isLoading.value = true;
    try {
      if (vehicleNameController.text.isEmpty ||
          vehicleNumberController.text.isEmpty ||
          vehicleCapacityController.text.isEmpty) {
        Get.snackbar("Error", "Please fill all fields");
        return;
      }

      if (userData.value == null) {
        Get.snackbar("Error", "User data not available");
        return;
      }

      final currentUser = userData.value!;
      final vehicle = VehicleModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        companyId: currentUser.uid,
        vehicleName: vehicleNameController.text,
        vehicleNumber: vehicleNumberController.text,
        vehicleCapacity: vehicleCapacityController.text,
        vehicleFilled: '0', 
      );

      await _firebaseFirestore
          .collection('vehicles')
          .doc(vehicle.id)
          .set(vehicle.toJson());

      
      await fetchVehicles();

      
      vehicleNameController.clear();
      vehicleNumberController.clear();
      vehicleCapacityController.clear();

      Get.snackbar(
        'Success',
        'Vehicle created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create vehicle: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}