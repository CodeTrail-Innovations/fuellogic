import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:get/get.dart';

import '../../../helper/services/fcm_service.dart';
import '../../auth/models/user_model.dart';
import '../models/order_model.dart';

class OrderDetailController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<OrderStatus> status;
  final Rx<PaymentStatus> pStatus;
  final String orderId;
  final Rx<OrderModel> order = OrderModel().obs;
  final Rx<UserModel?> companyData = Rx<UserModel?>(null);
  final Rx<UserModel?> driverData = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;

  final fcmService = Get.find<FcmService>();




  OrderDetailController({
    required OrderStatus status,
    required this.orderId,
    required OrderModel order,
    required PaymentStatus paymentStatus,
  })  : status = status.obs, pStatus = paymentStatus.obs {
    this.order.value = order;

    // paymentStatus = paymentStatus.obs;

    // Trigger data fetches based on order info
    if (order.companyId.isNotEmpty) {
      fetchCompanyData(order.companyId);
    }

    if (order.driverId != null && order.driverId!.isNotEmpty) {
      fetchDriverData(order.driverId!);
    }
  }



  void showOrderStatusBottomSheet(BuildContext context) {
    List<OrderStatus> availableStatuses = [];

    if (status.value == OrderStatus.pending) {
      availableStatuses = [OrderStatus.approved, OrderStatus.onTheWay, OrderStatus.delivered];
    } else if (status.value == OrderStatus.approved) {
      availableStatuses = [OrderStatus.onTheWay, OrderStatus.delivered];
    }else if (status.value == OrderStatus.onTheWay) {
      availableStatuses = [OrderStatus.onTheWay, OrderStatus.delivered];
    } else {
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Change Order Status',
                  style: AppTextStyles.largeStyle.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                24.vertical,
                Column(
                  children:
                      availableStatuses.map((orderStatus) {
                        final isSelected = orderStatus == status.value;
                        final textColor =
                            orderStatus == OrderStatus.delivered
                                ? AppColors.progressColor
                                : isSelected
                                ? AppColors.primaryColor
                                : AppColors.primaryColor.withCustomOpacity(0.7);

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? AppColors.primaryColor.withCustomOpacity(
                                      0.1,
                                    )
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            title: Text(
                              orderStatus.label,
                              style: AppTextStyles.regularStyle.copyWith(
                                color: textColor,
                              ),
                            ),
                            leading:
                                isSelected
                                    ? Icon(
                                      Icons.check_circle,
                                      color: AppColors.primaryColor,
                                    )
                                    : null,
                            onTap: () async {
                              order.value = order.value.copyWith(orderStatus: orderStatus);
                              await updateOrderStatus(orderStatus);
                              Get.back();
                            },
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),
          ),
    );
  }

  Future<void> updateOrderStatus(OrderStatus newStatus) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'orderStatus': newStatus.name,
      });
      status.value = newStatus;

      // order.value = order.value.copyWith(orderStatus: newStatus);

      unawaited(fcmService.notifyCustomer(order.value, 'Updates on your order', 'Your Order is ${newStatus.label}'));

      Get.back();
      // Get.back();
      Get.snackbar('Success', 'Order status updated to ${newStatus.label}',snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update status: $e',snackPosition: SnackPosition.BOTTOM);
    }
  }

  void showPaymentStatusBottomSheet(BuildContext context) {
    List<PaymentStatus> availableStatuses = [PaymentStatus.unpaid, PaymentStatus.paid];


    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Change Payment Status',
              style: AppTextStyles.largeStyle.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            24.vertical,
            Column(
              children:
              availableStatuses.map((paymentStatus) {
                final isSelected = paymentStatus == pStatus.value;
                final textColor =
                paymentStatus == PaymentStatus.unpaid
                    ? AppColors.progressColor
                    : isSelected
                    ? AppColors.primaryColor
                    : AppColors.primaryColor.withCustomOpacity(0.7);

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color:
                    isSelected
                        ? AppColors.primaryColor.withCustomOpacity(
                      0.1,
                    )
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    title: Text(
                      paymentStatus.label,
                      style: AppTextStyles.regularStyle.copyWith(
                        color: textColor,
                      ),
                    ),
                    leading:
                    isSelected
                        ? Icon(
                      Icons.check_circle,
                      color: AppColors.primaryColor,
                    )
                        : null,
                    onTap: () async {
                      order.value = order.value.copyWith(paymentStatus: paymentStatus);
                      await updatePaymentStatus(paymentStatus);
                      Get.back();
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> updatePaymentStatus(PaymentStatus newStatus) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'paymentStatus': newStatus.name,
      });
      pStatus.value = newStatus;

      // order.value = order.value.copyWith(orderStatus: newStatus);

      unawaited(fcmService.notifyCustomer(order.value, 'Updates on your order', 'Your Order is marked as ${newStatus.label}'));

      Get.back();
      // Get.back();
      Get.snackbar('Success', 'Order status updated to ${newStatus.label}',snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update status: $e',snackPosition: SnackPosition.BOTTOM);
    }
  }


  Future<void> fetchCompanyData(String companyId) async {
    log('Fetching Company Data');
    try {
      isLoading.value = true;
      final user = auth.currentUser;
      if (user != null) {
        final userDoc = await _firestore.collection('users').doc(companyId).get();

        if (userDoc.exists) {
          final userData = userDoc.data();
          if (userData != null) {
            this.companyData.value = UserModel.fromJson(userData);

          }
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data: $e',snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDriverData(String driverId) async {
    log('Fetching Driver Data');
    try {
      isLoading.value = true;
      final user = auth.currentUser;
      if (user != null) {
        final userDoc = await _firestore.collection('users').doc(driverId).get();

        if (userDoc.exists) {
          final userData = userDoc.data();
          if (userData != null) {
            this.driverData.value = UserModel.fromJson(userData);

          }
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data: $e',snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }




  void showEditDialog({
    required String field,
    required String title,
    required String initialValue,
  }) {
    final controller = TextEditingController(text: initialValue);

    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          keyboardType: field == 'orderTotal' ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            hintText: field == 'orderTotal' ? 'Enter total price' : 'Enter DC Book number',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final input = controller.text.trim();

              if (input.isEmpty) {
                Get.snackbar('Error', 'Field cannot be empty',snackPosition: SnackPosition.BOTTOM);
                return;
              }

              if (field == 'orderTotal') {
                final value = double.tryParse(input);
                if (value == null) {
                  Get.snackbar('Error', 'Please enter a valid number',snackPosition: SnackPosition.BOTTOM);
                  return;
                }
                unawaited(updateOrderField('orderTotal', value));
                // await updateOrderField('orderTotal', value);
                order.value = order.value.copyWith(orderTotal: value);
              } else if (field == 'dcBook') {
                unawaited(updateOrderField('dcBook', input));
                // await updateOrderField('dcBook', input);
                order.value = order.value.copyWith(dcBook: input);
              }

              Get.back(); // ✅ close dialog
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }



  Future<void> updateOrderField(String field, dynamic value) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        field: value,
      });

      if(field == 'orderTotal'){
        unawaited(fcmService.notifyCustomer(order.value,
            'Updates on your order',
            'Your Order total is ${value}'));
      }else if (field == 'dcBook') {
        unawaited(fcmService.notifyCustomer(order.value,
            'Updates on your order',
            'Your Order invoice is ${value}'));
      }

      Get.snackbar('Success', '$field updated', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update $field: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }





}
