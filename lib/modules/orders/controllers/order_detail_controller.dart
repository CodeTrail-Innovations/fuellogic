import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:get/get.dart';

class OrderDetailController extends GetxController {
  final OrderStatus? status;

  OrderDetailController({this.status});

  void showStatusBottomSheet(BuildContext context) {
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
                  'Status',
                  style: AppTextStyles.largeStyle.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                24.vertical,
                Column(
                  children:
                      OrderStatus.values
                          .where(
                            (orderStatus) =>
                                orderStatus == OrderStatus.onTheWay ||
                                orderStatus == OrderStatus.delivered,
                          )
                          .map((orderStatus) {
                            final isSelected = orderStatus == status;
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? AppColors.primaryColor
                                            .withCustomOpacity(0.1)
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ListTile(
                                title: Text(
                                  orderStatus.label,
                                  style: AppTextStyles.regularStyle.copyWith(
                                    color:
                                        orderStatus == OrderStatus.delivered
                                            ? AppColors.progressColor
                                            : isSelected
                                            ? AppColors.primaryColor
                                            : AppColors.primaryColor
                                                .withCustomOpacity(0.7),
                                  ),
                                ),
                                leading:
                                    isSelected
                                        ? Icon(
                                          Icons.check_circle,
                                          color: AppColors.primaryColor,
                                        )
                                        : null,
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            );
                          })
                          .toList(),
                ),
              ],
            ),
          ),
    );
  }
}
