import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/core/routes/app_router.dart';
import 'package:fuellogic/helper/constants/keys.dart';
import 'package:fuellogic/modules/auth/repositories/implementations/register_repo_impl.dart';
import 'package:fuellogic/utils/dialog_utils.dart';
import 'package:get/get.dart';

import '../../auth/models/user_model.dart';

class AddNewAdminController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();



  final isLoading = false.obs;


  Map<String, dynamic>? currentUserData;



  Future<void> handleSignUp() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();


    log('Name: $name, Email: $email');

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      DialogUtils.showAnimatedDialog(
        type: DialogType.error,
        title: 'Error',
        message: 'Name, email, and password are required',
      );
      return;
    }



    isLoading.value = true;
    User? user;


    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      user = userCredential.user;
      if (user != null) {
        final userModel = UserModel(
          uid: user.uid,
          email: email,
          displayName: name,
          role: UserRole.admin,
          photoURL: '',
          createdAt: Timestamp.now(),
        );

        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(userModel.toJson());

        Get.snackbar(
            'Success', 'New Admin account has been created successfully!',
            snackPosition: SnackPosition.BOTTOM);
        clearFields();
      } else {
        Get.snackbar(
            'Error', 'An error occurred. Please try later!',
            snackPosition: SnackPosition.BOTTOM);
      }
    }catch (e) {
      log('Error during sign-up: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCurrentUserData() async {
    try {
      final registerRepo = RegisterRepoImpl();
      currentUserData = await registerRepo.getCurrentUserData();
      if (currentUserData != null) {
        log('User Data: $currentUserData');
      } else {
        log('Failed to fetch user data');
      }
    } catch (e) {
      log('Error fetching user data: $e');
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

    void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    super.onClose();
    }
}
