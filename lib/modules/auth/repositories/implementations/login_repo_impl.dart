import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:fuellogic/modules/auth/repositories/implementations/home_repo_impl.dart';
import 'package:fuellogic/modules/auth/repositories/interfaces/home_repo.dart';
import 'package:fuellogic/modules/auth/repositories/interfaces/login_repo.dart';
import 'package:fuellogic/utils/dialog_utils.dart';
import 'package:get/get.dart';

import '../../../bottombar/screens/company_main_screen.dart';

class LoginRepoImpl implements LoginRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> userSignIn({
    required String email,
    required String password,
  }) async {
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

          DialogUtils.showAnimatedDialog(
            type: DialogType.success,
            title: 'Success',
            message: 'Login successful!',
          );

          Get.off(CustomBottomBar());

          if (!Get.isRegistered<HomeRepository>()) {
            Get.put(() => HomeRepositoryImpl());
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
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideLoadingDialog();
      String errorMessage = _getFirebaseAuthErrorMessage(e);
      DialogUtils.showAnimatedDialog(
        type: DialogType.error,
        title: 'Login Failed',
        message: errorMessage,
      );
    } catch (e) {
      DialogUtils.hideLoadingDialog();
      debugPrint('Unexpected error: $e');
      DialogUtils.showAnimatedDialog(
        type: DialogType.error,
        title: 'Error',
        message: 'An unexpected error occurred. Please try again later.',
      );
    }
  }

  String _getFirebaseAuthErrorMessage(FirebaseAuthException e) {
    const errorMessages = {
      'invalid-email': 'The email address is badly formatted.',
      'user-disabled': 'This user account has been disabled.',
      'user-not-found': 'No account found with this email.',
      'auth/user-not-found': 'No account found with this email.',
      'wrong-password': 'Incorrect password. Please try again.',
      'too-many-requests':
          'We have blocked all requests from this device due to unusual activity. Try again later.',
      'network-request-failed':
          'A network error has occurred. Please check your internet connection.',
      'device-mismatch':
          'This account is already logged in on another device. Please log out from the other device first.',
    };

    return errorMessages[e.code] ??
        'An unknown error occurred. Please try again.';
  }
}
