import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/home/screens/components/order_status_label.dart';
import 'package:fuellogic/modules/orders/screens/order_detail_screen.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final List<Color> colors;
    final List<double> stops;

    switch (status) {
      case OrderStatus.delivered:
        colors = [AppColors.greyColor, AppColors.greyColor];
        stops = [0.0, 1.0];
        break;
      case OrderStatus.onTheWay:
        colors = [
          AppColors.greyColor,
          AppColors.primaryColor.withCustomOpacity(.2),
        ];
        stops = [0.8, 1.0];
        break;
      case OrderStatus.approved:
        colors = [
          AppColors.greyColor,
          AppColors.primaryColor.withCustomOpacity(.2),
        ];
        stops = [0.35, 1.0];
        break;
      case OrderStatus.pending:
        colors = [
          AppColors.greyColor,
          AppColors.primaryColor.withCustomOpacity(.2),
        ];
        stops = [0.15, 1.0];
        break;
    }

    return InkWell(
      onTap: () => Get.to(() => OrderDetailScreen(status: status)),
      child: Container(
        padding: EdgeInsets.all(16),
        height: 150,
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
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("From", style: AppTextStyles.regularStyle),
                    4.horizontal,
                    Text(
                      "Location",
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                8.vertical,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.clockIcon,
                      fit: BoxFit.cover,
                      width: 18,
                      height: 18,
                    ),
                    6.horizontal,
                    Text(
                      "Oct 26-29 6:00 PM",
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.mainColor.withCustomOpacity(.6),
                      ),
                    ),
                  ],
                ),
                16.vertical,
                Image.network(
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                  "https://upload.wikimedia.org/wikipedia/en/thumb/e/e8/Shell_logo.svg/1200px-Shell_logo.svg.png",
                ),
              ],
            ),
            Spacer(),
            OrderStatusLabel(status: status),
          ],
        ),
      ),
    );
  }
}
