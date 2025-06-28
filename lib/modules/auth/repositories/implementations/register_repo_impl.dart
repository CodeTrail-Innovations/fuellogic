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
  @override
  Future<void> userSignUp({
    required String name,
    required String email,
    required String password,
    required UserRole role,
    required String comapanyId,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? user = userCredential.user;

      if (user != null) {
        String roleString = role.toString().split('.').last;

        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'displayName': name,
          'userRole': roleString,
          'comapanyId': comapanyId,
          'createdAt': FieldValue.serverTimestamp(),
        });

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
      String errorMessage =
          e is FirebaseAuthException
              ? _getFirebaseAuthErrorMessage(e)
              : 'An error occurred. Please try again.';

      DialogUtils.showAnimatedDialog(
        type: DialogType.error,
        title: 'Registration Failed',
        message: errorMessage,
      );
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
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'auth/user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'invalid-credential':
        return 'The email or password is incorrect.';
      case 'invalid-verification-code':
        return 'The verification code is invalid.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case 'requires-recent-login':
        return 'Please sign in again to perform this action.';
      case 'too-many-requests':
        return 'We have blocked all requests from this device due to unusual activity. Try again later.';
      case 'network-request-failed':
        return 'A network error has occurred. Please check your internet connection.';
      case 'timeout':
        return 'The request has timed out. Please try again later.';
      case 'user-token-expired':
        return 'The user\'s token has expired. Please log in again.';
      case 'invalid-user-token':
        return 'The user\'s token is invalid. Please log in again.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials.';
      case 'auth-domain-config-required':
        return 'Authentication is not properly configured. Please contact support.';
      case 'app-not-authorized':
        return 'This app is not authorized to use Firebase Authentication. Please check your configuration.';
      case 'captcha-check-failed':
        return 'The CAPTCHA verification failed. Please try again.';
      case 'web-context-cancelled':
        return 'The operation was cancelled by the user.';
      case 'web-context-already-present':
        return 'An auth request is already being processed. Please wait.';
      case 'internal-error':
        return 'An internal error occurred. Please try again.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}
