import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:get/get.dart';

import '../models/order_model.dart';

class OrderDetailController extends GetxController {
  final Rx<OrderStatus> status;
  final String orderId;
  final Rx<OrderModel> order = OrderModel().obs;


  // OrderDetailController({required OrderStatus status, required this.orderId, required this.order})
  //   : status = status.obs;

  OrderDetailController({
    required OrderStatus status,
    required this.orderId,
    required OrderModel order,
  })  : status = status.obs {
    this.order.value = order;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void showStatusBottomSheet(BuildContext context) {
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
                  'Change Status',
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
      Get.back();
      Get.back();
      Get.snackbar('Success', 'Order status updated to ${newStatus.label}');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update status: $e');
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
                Get.snackbar('Error', 'Field cannot be empty');
                return;
              }

              if (field == 'orderTotal') {
                final value = double.tryParse(input);
                if (value == null) {
                  Get.snackbar('Error', 'Please enter a valid number');
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
      Get.snackbar('Success', '$field updated', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update $field: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }





}
