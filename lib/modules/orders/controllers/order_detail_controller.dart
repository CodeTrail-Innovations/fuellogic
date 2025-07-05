import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:get/get.dart';

class OrderDetailController extends GetxController {
  final Rx<OrderStatus> status;
  final String orderId;

  OrderDetailController({required OrderStatus status, required this.orderId})
    : status = status.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void showStatusBottomSheet(BuildContext context) {
    List<OrderStatus> availableStatuses = [];

    if (status.value == OrderStatus.approved) {
      availableStatuses = [OrderStatus.approved, OrderStatus.onTheWay];
    } else if (status.value == OrderStatus.onTheWay) {
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
}
