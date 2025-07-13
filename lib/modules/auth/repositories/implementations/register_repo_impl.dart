import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/helper/constants/keys.dart';
import 'package:fuellogic/helper/utils/hive_utils.dart';
import 'package:fuellogic/modules/auth/models/user_model.dart';
import 'package:fuellogic/modules/auth/repositories/interfaces/register_repo.dart';
import 'package:fuellogic/modules/bottombar/screens/custom_bottom_bar.dart';
import 'package:fuellogic/utils/dialog_utils.dart';
import 'package:get/get.dart';

class RegisterRepoImpl implements RegisterRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> validateCompanyId(String companyUid) async {
    log('[RegisterRepo] Validating company ID: $companyUid');
    try {
      if (companyUid.isEmpty || companyUid.length < 8) {
        log('Invalid company ID format');
        return false;
      }

      final querySnapshot =
          await _firestore
              .collection('users')
              .where('role', isEqualTo: UserRole.company.value)
              .where('uid', isEqualTo: companyUid)
              .limit(1)
              .get();

      if (querySnapshot.docs.isEmpty) {
        log('No company found with this ID');
        return false;
      }

      log('Company validation successful');
      return true;
    } catch (e) {
      log('Error validating company UID: $e');
      return false;
    }
  }

  Future<void> addDriverToCompany({
    required String companyId,
    required String driverUid,
    required String driverName,
    required String driverEmail,
  }) async {
    log('[RegisterRepo] Adding driver to company: $companyId');
    try {
      Map<String, dynamic> driverInfo = {
        'uid': driverUid,
        'name': driverName,
        'email': driverEmail,
        'addedAt': Timestamp.now(),
      };

      await _firestore.collection('users').doc(companyId).update({
        'driver': FieldValue.arrayUnion([driverInfo]),
      });

      log('Driver added to company successfully');
    } catch (e) {
      log('Error adding driver to company: $e');
      throw Exception(
        'Failed to add driver to company. Registration cancelled.',
      );
    }
  }

  @override
  Future<void> userSignUp({
    required String name,
    required String email,
    required String password,
    required UserRole role,
    required String companyId,
    required String phoneNumber,
  }) async {
    log('[RegisterRepo] Starting user signup for: $email');
    User? user;

    try {
      if (role == UserRole.driver) {
        bool isValidCompany = await validateCompanyId(companyId);
        if (!isValidCompany) {
          throw Exception(
            'Invalid company ID. Please check with your company administrator.',
          );
        }
      }

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      user = userCredential.user;

      if (user != null) {
        final userModel = UserModel(
          uid: user.uid,
          email: email,
          displayName: name,
          companyId: role == UserRole.driver ? companyId : user.uid,
          role: role,
          photoURL: '',
          phoneNumber: phoneNumber,
          driver: role == UserRole.company ? [] : [],
          createdAt: Timestamp.now(),
        );

        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(userModel.toJson());

        if (role == UserRole.driver && companyId.isNotEmpty) {
          try {
            await addDriverToCompany(
              companyId: companyId,
              driverUid: user.uid,
              driverName: name,
              driverEmail: email,
            );
          } catch (e) {
            await user.delete();
            await _firestore.collection('users').doc(user.uid).delete();
            rethrow;
          }
        }
        HiveBox().setValue(key: roleKey, value: role == UserRole.company ? companyRoleKey :driverRoleKey);
        saveDeviceToken();
        Get.offAll(() => CustomBottomBar(isCompany: role == UserRole.company ? true :false,));
        DialogUtils.showAnimatedDialog(
          type: DialogType.success,
          title: 'Success',
          message: 'Your account has been created successfully!',
          positiveButtonText: 'Continue',
        );
      }
    } catch (e) {
      log('Registration error: $e');

      String errorMessage;
      if (e is FirebaseAuthException) {
        errorMessage = _getFirebaseAuthErrorMessage(e);
      } else if (e.toString().contains('Invalid company ID')) {
        errorMessage = e.toString().replaceAll('Exception: ', '');
      } else if (e.toString().contains('Failed to add driver to company')) {
        errorMessage =
            'Failed to register driver with company. Please try again.';
      } else {
        errorMessage = 'Registration failed. Please try again.';
      }

      DialogUtils.showAnimatedDialog(
        type: DialogType.error,
        title: 'Registration Failed',
        message: errorMessage,
      );

      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>?> getCurrentUserData() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          return UserModel.fromJson(
            userDoc.data() as Map<String, dynamic>,
          ).toJson();
        }
      }
      return null;
    } catch (e) {
      log('Error fetching user data: $e');
      return null;
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

  String _getFirebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'invalid-credential':
        return 'The email or password is incorrect.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}
