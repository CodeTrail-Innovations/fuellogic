import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/core/routes/app_router.dart';
import 'package:fuellogic/helper/services/auth_service.dart';
import 'package:fuellogic/modules/auth/models/user_model.dart';
import 'package:get/get.dart';

import '../../../data_manager/models/user_model.dart';

class ProfileController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Rx<UserModel?> userData = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchCurrentUserData();
    super.onInit();
  }

  Future<void> fetchCurrentUserData() async {
    try {
      isLoading.value = true;
      final user = auth.currentUser;
      if (user != null) {
        debugPrint('user value');
        debugPrint('user value: $user');
        final userDoc = await firestore.collection('companies').doc(user.uid).get();

        if (userDoc.exists) {
          final userData = userDoc.data();
          if (userData != null) {
            debugPrint('2222');
            debugPrint('$userData');
            this.userData.value = UserModel.fromMap(userData);
          }
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> fetchCompanyNameForDriver() async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser == null) return null;

      final userDoc =
          await firestore.collection('users').doc(currentUser.uid).get();
      if (!userDoc.exists) return null;

      final currentUserData = UserModel.fromMap(userDoc.data()!);

      if (currentUserData.role == 'driver') {
        final companyId = currentUserData.companyId;

        if (companyId!.isEmpty) return null;

        final companyDoc =
            await firestore.collection('users').doc(companyId).get();

        if (companyDoc.exists) {
          final companyData = UserModel.fromMap(companyDoc.data()!);
          return companyData.name;
        }
      }
    } catch (e) {
      log('Error fetching company name: $e');
    }
    return null;
  }

  void showCompanyKeyDialog(BuildContext context) {
    if (userData.value == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withCustomOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.key_rounded,
                        color: const Color(0xFFFFFFFF),
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your Company Key',
                        style: AppTextStyles.largeStyle.copyWith(
                          fontSize: 20,
                          color: AppColors.whiteColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        'Copy your unique company key below:',
                        style: AppTextStyles.paragraphStyle.copyWith(
                          color: AppColors.whiteColor.withCustomOpacity(.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(
                              0xFFFFFFFF,
                            ).withCustomOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: SelectableText(
                                userData.value!.uid,
                                style: AppTextStyles.regularStyle.copyWith(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                            12.vertical,
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(text: userData.value!.uid),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Company key copied!'),
                                    backgroundColor: AppColors.primaryColor,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor
                                      .withCustomOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.copy_rounded,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      24.vertical,
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: AppColors.whiteColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Done',
                            style: AppTextStyles.regularStyle.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void logout() async {
    try {
      AuthService().signOut();
    } catch (e) {
      log('Error logging out: $e');
    }
  }
}
