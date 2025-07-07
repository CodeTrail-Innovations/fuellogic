import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuellogic/modules/auth/models/user_model.dart';
import 'package:fuellogic/modules/company/repositories/company_repository.dart';
import 'package:get/get.dart';

import '../../../data_manager/models/user_model.dart';

class CompanyMainController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<UserModel?> userData = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final _companyRepository = CompanyRepository();


  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;
    // repo.ordersByCustomer(customerId.value)
    //     .listen((list) {
    //   orders.assignAll(list);
    //   _calculateStats(list);
    // });

    _companyRepository.getCompanyProfile().listen((companyProfile){
      userData.value = companyProfile;
    });

    // try {
    //   // 🔸 ensure _userId is loaded
    //   _userStream = _companyRepository.getCompanyProfile();
    //
    //   _userSubscription = _userStream!.listen((user) {
    //     userData.value = user;
    //     _logUserData(user);
    //   }, onError: (e) {
    //     log('Error listening to user stream: $e');
    //     Get.snackbar('Error', 'Failed to fetch company profile');
    //   });
    // } catch (e, stackTrace) {
    //   log('Error initializing controller: $e', stackTrace: stackTrace);
    //   Get.snackbar('Error', 'Something went wrong');
    // } finally {
    //   isLoading.value = false;
    // }
  }

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
          .collection('companies')
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

      // final currentUser = UserModel.fromJson(userDataMap);
      final currentUser = UserModel.fromMap(userDataMap);
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
Name: ${user.name}
Role: ${user.role}
Company ID: ${user.companyId}
Created At: ${user.createdAt}
=======================================
''', name: 'UserData');

    log(user.toJson().toString(), name: 'UserDataJSON');
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

  // Future<String?> getCompanyOwnerName() async {
  //   if (userData.value?.role != UserRole.driver ||
  //       userData.value?.companyId.isEmpty ?? true) {
  //     return null;
  //   }
  //
  //   try {
  //     final doc = await _firestore
  //         .collection('users')
  //         .doc(userData.value!.companyId)
  //         .get();
  //
  //     return doc['displayName'] as String?;
  //   } catch (e) {
  //     log('Error fetching company owner: $e');
  //     return null;
  //   }
  // }
}
