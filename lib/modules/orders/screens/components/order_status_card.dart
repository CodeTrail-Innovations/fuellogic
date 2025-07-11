import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/home/screens/components/order_status_label.dart';
import 'package:fuellogic/modules/orders/controllers/order_detail_controller.dart';

class OrderStatusCard extends StatelessWidget {
  final OrderStatus status;
  final OrderDetailController controller;

  const OrderStatusCard({
    super.key,
    required this.status,
    required this.controller,
  });

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
          OrderStatusLabel(
            status: status,
            onTap: () {
              if (status == OrderStatus.approved ||
                  status == OrderStatus.onTheWay) {
                controller.showStatusBottomSheet(context);
              }
            },
          ),
          12.vertical,
          _buildStatusProgress(status),
        ],
      ),
    );
  }

  Widget _buildStatusProgress(OrderStatus status) {
    final steps = ['Order Placed', 'Approved', 'On the Way', 'Delivered'];

    int currentStep = 0;
    switch (status) {
      case OrderStatus.pending:
        currentStep = 0;
        break;
      case OrderStatus.approved:
        currentStep = 1;
        break;
      case OrderStatus.onTheWay:
        currentStep = 2;
        break;
      case OrderStatus.delivered:
        currentStep = 3;
        break;
    }

    return Row(
      children: List.generate(steps.length, (index) {
        final isActive = index <= currentStep;
        final isLast = index == steps.length - 1;

        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor:
                          isActive
                              ? AppColors.primaryColor
                              : AppColors.blackColor.withCustomOpacity(0.2),
                      child: Icon(
                        isActive ? Icons.check : Icons.hourglass_empty,
                        size: 12,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    4.vertical,
                    Text(
                      steps[index],
                      style: AppTextStyles.captionStyle.copyWith(
                        color:
                            isActive
                                ? AppColors.primaryColor
                                : AppColors.blackColor.withCustomOpacity(0.5),
                        fontWeight:
                            isActive ? FontWeight.w600 : FontWeight.normal,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    height: 2,
                    margin: const EdgeInsets.only(bottom: 20),
                    color:
                        isActive
                            ? AppColors.primaryColor
                            : AppColors.blackColor.withCustomOpacity(0.2),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.approved:
        return Colors.blue;
      case OrderStatus.onTheWay:
        return AppColors.primaryColor;
      case OrderStatus.delivered:
        return Colors.green;
    }
  }
}
