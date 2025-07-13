import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';

class PaymentStatusLabel extends StatelessWidget {
  final PaymentStatus status;
  final VoidCallback? onTap;

  const PaymentStatusLabel({super.key, required this.status, this.onTap});

  Color _getStatusColor(BuildContext context) {
    switch (status) {
      case PaymentStatus.unpaid:
        return AppColors.primaryColor;
      case PaymentStatus.paid:
        return AppColors.successColor;
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (status) {
      case PaymentStatus.unpaid:
        return AppColors.blackColor;
      case PaymentStatus.paid:
        return Colors.black;

    }
  }

  Color _getBackgroundColor(BuildContext context) {
    switch (status) {
      case PaymentStatus.unpaid:
        return Colors.transparent;
      case PaymentStatus.paid:
        return AppColors.successColor;

    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBackgroundColor(context),
          border: Border.all(
            color: _getStatusColor(context),
            width: status == PaymentStatus.paid ? 1.0 : 0.0,
          ),
        ),
        child: Text(
          status.label,
          style: AppTextStyles.captionStyle.copyWith(
            color: _getTextColor(context),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
