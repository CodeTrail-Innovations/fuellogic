import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fuellogic/modules/auth/models/user_model.dart';
import 'package:get/get.dart';

class BottombarController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<UserModel?> userData = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;

  Future<void> fetchCurrentUserData() async {
    try {
      isLoading.value = true;
      final user = _auth.currentUser;

      if (user == null) {
        log('No authenticated user found');
        userData.value = null;
        return;
      }

      final DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(user.uid)
          .get()
          .timeout(const Duration(seconds: 10));

      if (!userDoc.exists) {
        log('User document does not exist for uid: ${user.uid}');
        userData.value = null;
        return;
      }

      final userDataMap = userDoc.data() as Map<String, dynamic>?;

      if (userDataMap == null || userDataMap.isEmpty) {
        log('User document data is empty for uid: ${user.uid}');
        userData.value = null;
        return;
      }

      final currentUser = UserModel.fromJson(userDataMap);
      userData.value = currentUser;

      _logUserData(currentUser);
    } on FirebaseException catch (e) {
      _handleFirebaseError(e);
    } on TimeoutException catch (e) {
      _handleTimeoutError(e);
    } catch (e, stackTrace) {
      _handleGenericError(e, stackTrace);
    } finally {
      isLoading.value = false;
    }
  }

  void _logUserData(UserModel user) {
    log('''
========== CURRENT USER DATA ==========
UID: ${user.uid}
Email: ${user.email}
Name: ${user.displayName}
Role: ${user.role.label}
Company ID: ${user.companyId}
Created At: ${user.createdAt.toDate()}
=======================================
''', name: 'UserData');

    log(user.toJson().toString(), name: 'UserDataJSON');
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



  void _handleFirebaseError(FirebaseException e) {
    final errorMessage = 'Firebase error: ${e.code} - ${e.message}';
    log(errorMessage, error: e, stackTrace: e.stackTrace);
    Get.snackbar(
      'Error',
      'Failed to fetch user data: ${e.code}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _handleTimeoutError(TimeoutException e) {
    const errorMessage = 'Request timed out while fetching user data';
    log(errorMessage, error: e);
    Get.snackbar(
      'Timeout',
      'The request took too long. Please try again.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _handleGenericError(Object e, StackTrace stackTrace) {
    final errorMessage = 'Unexpected error: $e';
    log(errorMessage, error: e, stackTrace: stackTrace);
    Get.snackbar(
      'Error',
      'An unexpected error occurred',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<String?> _getFcmToken() async {
    await Firebase.initializeApp();
    return FirebaseMessaging.instance.getToken();
  }

}
