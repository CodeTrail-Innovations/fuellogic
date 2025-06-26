import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DialogType { success, error, warning, info }

class DialogUtils {
  static void showAnimatedDialog({
    required DialogType type,
    required String title,
    required String message,
    String? positiveButtonText,
    VoidCallback? positiveButtonAction,
    String? negativeButtonText,
    VoidCallback? negativeButtonAction,
    bool barrierDismissible = true,
  }) {
    Color backgroundColor;
    IconData icon;
    Color iconColor;

    switch (type) {
      case DialogType.success:
        backgroundColor = Colors.green.shade50;
        icon = Icons.check_circle;
        iconColor = Colors.green;
        break;
      case DialogType.error:
        backgroundColor = Colors.red.shade50;
        icon = Icons.error;
        iconColor = Colors.red;
        break;
      case DialogType.warning:
        backgroundColor = Colors.orange.shade50;
        icon = Icons.warning;
        iconColor = Colors.orange;
        break;
      case DialogType.info:
        backgroundColor = Colors.blue.shade50;
        icon = Icons.info;
        iconColor = Colors.blue;
        break;
    }

    Get.dialog(
      AlertDialog(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: Icon(icon, size: 48, color: iconColor),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          if (negativeButtonText != null)
            TextButton(
              onPressed: negativeButtonAction ?? () => Get.back(),
              child: Text(negativeButtonText),
            ),
          TextButton(
            onPressed: positiveButtonAction ?? () => Get.back(),
            child: Text(positiveButtonText ?? 'OK'),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static void showLoadingDialog({String message = 'Loading...'}) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Text(message),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void hideLoadingDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
