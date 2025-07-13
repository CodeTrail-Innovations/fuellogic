import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/home/screens/components/order_status_label.dart';
import 'package:fuellogic/modules/orders/controllers/order_detail_controller.dart';

import '../../../../helper/constants/keys.dart';
import '../../../../helper/utils/hive_utils.dart';
import '../../../home/screens/components/payment_status_label.dart';

class PaymentStatusCard extends StatelessWidget {
  final PaymentStatus status;
  final OrderDetailController controller;

  PaymentStatusCard({
    super.key,
    required this.status,
    required this.controller,
  });

  final role = HiveBox().getValue(key: roleKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withCustomOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getStatusColor(status).withCustomOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          PaymentStatusLabel(
            status: status,
            onTap: () {

                if(role == adminRoleKey){
                  controller.showPaymentStatusBottomSheet(context);
                }


            },
          ),
          12.vertical,
          _buildStatusProgress(status),
        ],
      ),
    );
  }

  Widget _buildStatusProgress(PaymentStatus status) {
    final steps = ['Unpaid', 'Paid'];
    int currentStep = status == PaymentStatus.paid ? 1 : 0;

    return Row(
      children: [
        // Left Step
        Expanded(
          flex: 2,
          child: Column(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: currentStep >= 0
                    ? AppColors.primaryColor
                    : AppColors.blackColor.withCustomOpacity(0.2),
                child: Icon(
                  currentStep >= 0 ? Icons.check : Icons.hourglass_empty,
                  size: 12,
                  color: AppColors.whiteColor,
                ),
              ),
              4.vertical,
              Text(
                steps[0],
                style: AppTextStyles.captionStyle.copyWith(
                  color: currentStep >= 0
                      ? AppColors.primaryColor
                      : AppColors.blackColor.withCustomOpacity(0.5),
                  fontWeight:
                  currentStep >= 0 ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        // Line between steps
        Expanded(
          flex: 6,
          child: Container(
            height: 2,
            margin: const EdgeInsets.only(bottom: 20),
            color: currentStep >= 1
                ? AppColors.primaryColor
                : AppColors.blackColor.withCustomOpacity(0.2),
          ),
        ),

        // Right Step
        Expanded(
          flex: 2,
          child: Column(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: currentStep >= 1
                    ? AppColors.primaryColor
                    : AppColors.blackColor.withCustomOpacity(0.2),
                child: Icon(
                  currentStep >= 1 ? Icons.check : Icons.hourglass_empty,
                  size: 12,
                  color: AppColors.whiteColor,
                ),
              ),
              4.vertical,
              Text(
                steps[1],
                style: AppTextStyles.captionStyle.copyWith(
                  color: currentStep >= 1
                      ? AppColors.primaryColor
                      : AppColors.blackColor.withCustomOpacity(0.5),
                  fontWeight:
                  currentStep >= 1 ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }


  Color _getStatusColor(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.unpaid:
        return Colors.orange;
      case PaymentStatus.paid:
        return Colors.green;
    }
  }
}
