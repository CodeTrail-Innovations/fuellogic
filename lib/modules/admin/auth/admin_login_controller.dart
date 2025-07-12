import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/enums/enum.dart';
import '../../../core/routes/app_router.dart';
import '../../../helper/constants/keys.dart';
import '../../../helper/utils/hive_utils.dart';
import '../../../utils/dialog_utils.dart';

class AdminLoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final isLoading = false.obs;



  Future<void> handleSignIn({
    required String email,
    required String password,
  }) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      DialogUtils.showAnimatedDialog(
        type: DialogType.error,
        title: 'Error',
        message: 'Please enter both email and password',
      );
      return;
    }

    isLoading.value = true;


    try {

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          DialogUtils.hideLoadingDialog();
          final userData = userDoc.data() as Map<String, dynamic>;
          final userRole = userData['role'] ?? 'unknown';

          log('user doc data fetched');
          log(userData.toString());
          log('User Role: $userRole');

          if(userRole == adminRoleKey){
            HiveBox().setValue(key: roleKey, value: adminRoleKey,);

            // unawaited(saveDeviceToken());
            saveDeviceToken();

            Get.offAllNamed(AppRoutes.adminMainScreen);
          } else {
            _auth.signOut();
            HiveBox().clearAppSession();
            DialogUtils.showAnimatedDialog(
              type: DialogType.error,
              title: 'Invalid Login',
              message: 'Please enter correct Admin credentials',
            );

          }



        } else {
          DialogUtils.hideLoadingDialog();
          throw FirebaseAuthException(
            code: 'user-not-found',
            message: 'No user data found. Please register first.',
          );
        }
      } else {
        DialogUtils.hideLoadingDialog();
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user found with the provided credentials.',
        );
      }
      // await loginRepo.userSignIn(email: email, password: password);
    } catch (e) {
      log('Error during sign-in: $e');
      DialogUtils.showAnimatedDialog(
        type: DialogType.error,
        title: 'Sign-In Failed',
        message: 'An unexpected error occurred. Please try again later.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveDeviceToken() async {
    try {
      final fcmToken = await _getFcmToken();
      final user = _auth.currentUser;

      if (user != null && fcmToken != null) {
        final uid = user.uid;

        await FirebaseFirestore.instance
            .collection('device_tokens')
            .doc(uid)
            .set({
          'device_token': fcmToken,
          'role': adminRoleKey,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        log('✅ FCM token saved for UID: $uid');
      } else {
        log('⚠️ User not authenticated or FCM token is null');
      }
    } catch (e) {
      log('❌ Error saving device token: $e');
    }
  }



  Future<String?> _getFcmToken() async {
    await Firebase.initializeApp();
    return FirebaseMessaging.instance.getToken();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}