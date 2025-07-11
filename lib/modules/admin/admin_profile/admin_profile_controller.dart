import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuellogic/core/routes/app_router.dart';
import 'package:fuellogic/helper/utils/hive_utils.dart';
import 'package:fuellogic/modules/auth/models/user_model.dart';

class AdminProfileController extends GetxController {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Rx<UserModel?> userData = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchCurrentUserData();
    // .then((_) {
    //   if (userData.value?.role.value == UserRole.driver.value) {
    //     fetchAssignedVehicle();
    //   }
    //   fetchCompanyNameForDriver();
    // });
    super.onInit();
  }

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
            // displayNameController.text = this.userData.value?.displayName ?? '';
            // phoneNumberController.text = this.userData.value?.phoneNumber ?? '';
            // addressController.text = this.userData.value?.address ?? '';
          }
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data: $e');
    } finally {
      isLoading.value = false;
    }
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