import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';

class OrderStatusLabel extends StatelessWidget {
  final OrderStatus status;

  const OrderStatusLabel({super.key, required this.status});

  Color _getStatusColor(BuildContext context) {
    switch (status) {
      case OrderStatus.onTheWay:
        return AppColors.primaryColor;
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.approved:
        return Colors.green;
      case OrderStatus.delivered:
        return Colors.blue;
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (status) {
      case OrderStatus.onTheWay:
        return AppColors.primaryColor;
      case OrderStatus.pending:
        return Colors.white;
      case OrderStatus.approved:
        return Colors.white;
      case OrderStatus.delivered:
        return Colors.white;
    }
  }

  Color _getBackgroundColor(BuildContext context) {
    switch (status) {
      case OrderStatus.onTheWay:
        return Colors.transparent;
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.approved:
        return Colors.green;
      case OrderStatus.delivered:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: _getBackgroundColor(context),
        border: Border.all(
          color: _getStatusColor(context),
          width: status == OrderStatus.onTheWay ? 1.0 : 0.0,
        ),
      ),
      child: Text(
        status.label,
        style: AppTextStyles.captionStyle.copyWith(
          color: _getTextColor(context),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
