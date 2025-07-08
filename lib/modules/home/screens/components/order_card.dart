import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/constant/app_fonts.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/home/screens/components/order_status_label.dart';
import 'package:fuellogic/modules/orders/models/order_model.dart';
import 'package:fuellogic/modules/orders/screens/order_detail_screen.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final OrderStatus status = order.orderStatus;

    final List<Color> colors;
    final List<double> stops;

    switch (status) {
      case OrderStatus.delivered:
        colors = [
          AppColors.greyColor.withCustomOpacity(.7),
          AppColors.greyColor.withCustomOpacity(.5),
        ];
        stops = [0.0, 1.0];
        break;
      case OrderStatus.onTheWay:
        colors = [
          AppColors.greyColor.withCustomOpacity(.5),
          AppColors.primaryColor.withCustomOpacity(0.2),
        ];
        stops = [0.8, 1.0];
        break;
      case OrderStatus.approved:
        colors = [
          AppColors.greyColor.withCustomOpacity(.5),
          AppColors.primaryColor.withCustomOpacity(0.2),
        ];
        stops = [0.35, 1.0];
        break;
      case OrderStatus.pending:
        colors = [
          AppColors.greyColor.withCustomOpacity(.5),
          AppColors.primaryColor.withCustomOpacity(0.2),
        ];
        stops = [0.15, 1.0];
        break;
    }

    return InkWell(
      onTap: () => Get.to(() => OrderDetailScreen(order: order)),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 12),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: colors,
            stops: stops,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("From", style: AppTextStyles.regularStyle),
                        4.horizontal,
                        Text(
                          order.location,
                          style: AppTextStyles.regularStyle.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.clockIcon,
                          width: 18,
                          height: 18,
                        ),
                        6.horizontal,
                        Text(
                          order.date,
                          style: AppTextStyles.regularStyle.copyWith(
                            color: AppColors.mainColor.withCustomOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    Image.network(
                      height: 24,
                      width: 24,
                      fit: BoxFit.cover,
                      "https://upload.wikimedia.org/wikipedia/en/thumb/e/e8/Shell_logo.svg/1200px-Shell_logo.svg.png",
                    ),
                  ],
                ),
                const Spacer(),
                OrderStatusLabel(status: status),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 4,
              children: [
                Text(
                  "Order by:",
                  style: AppTextStyles.paragraphStyle.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                Text(
                  (order.driverName == null || order.driverName!.isEmpty)
                      ? "Company"
                      : order.driverName!,
                  style: AppTextStyles.paragraphStyle.copyWith(
                    color: AppColors.primaryColor,
                    fontFamily: AppFonts.publicSansBoldItalic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
