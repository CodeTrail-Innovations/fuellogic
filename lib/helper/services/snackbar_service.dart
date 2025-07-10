import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarService {
   static void showError(String message) {
    Get.showSnackbar(
      GetSnackBar(
        title: 'Error',
        message: message,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error_outline, color: Colors.white),
      ),
    );
  }

   static void showSuccess(String message) {
    Get.showSnackbar(
      GetSnackBar(
        title: 'Success',
        message: message,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      ),
    );
  }
}
