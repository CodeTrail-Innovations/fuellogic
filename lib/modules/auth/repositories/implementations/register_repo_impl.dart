import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuellogic/core/constant/custom_bottom_bar.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/auth/repositories/interfaces/register_repo.dart';
import 'package:fuellogic/utils/dialog_utils.dart';
import 'package:get/get.dart';

class RegisterRepoImpl implements RegisterRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> validateCompanyId(String companyId) async {
    try {
      DocumentSnapshot companyDoc =
          await _firestore.collection('users').doc(companyId).get();

      if (companyDoc.exists) {
        Map<String, dynamic> companyData =
            companyDoc.data() as Map<String, dynamic>;
        String userRole = companyData['userRole'] ?? '';
        return userRole.toLowerCase() == 'company';
      }
      return false;
    } catch (e) {
      log('Error validating company ID: $e');
      return false;
    }
  }

  Future<void> addDriverToCompany({
    required String companyId,
    required String driverUid,
    required String driverName,
    required String driverEmail,
  }) async {
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

      log('Driver added to company driver list successfully');
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
  }) async {
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
        String roleString = role.toString().split('.').last;

        Map<String, dynamic> userData = {
          'uid': user.uid,
          'email': email,
          'displayName': name,
          'userRole': roleString,
          'companyId': role == UserRole.driver ? companyId : '',
          'createdAt': FieldValue.serverTimestamp(),
        };

        if (role == UserRole.company) {
          userData['driver'] = [];
        }

        await _firestore.collection('users').doc(user.uid).set(userData);

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

        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();
        log('Stored user data: ${doc.data()}');

        Get.off(() => CustomBottomBar());
        DialogUtils.showAnimatedDialog(
          type: DialogType.success,
          title: 'Success',
          message: 'Your account has been created successfully!',
          positiveButtonText: 'Continue',
        );
      }
    } catch (e) {
      log('EXCEPTION: $e', stackTrace: e is Error ? e.stackTrace : null);

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
          return userDoc.data() as Map<String, dynamic>;
        } else {
          log('User document does not exist in Firestore');
          return null;
        }
      } else {
        log('No user is currently logged in');
        return null;
      }
    } catch (e) {
      log('Error fetching user data: $e');
      return null;
    }
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
