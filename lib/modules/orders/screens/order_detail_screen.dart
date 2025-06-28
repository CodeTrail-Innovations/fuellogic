import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/home/screens/components/order_status_label.dart';
import 'package:fuellogic/modules/orders/controllers/order_detail_controller.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, this.status});
  final OrderStatus? status;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController(status: status));

    log('OrderDetailScreen: $status', name: 'OrderDetailScreen');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Order Detail',
          style: AppTextStyles.regularStyle.copyWith(
            color: AppColors.mainColor,
          ),
        ),
        backgroundColor: AppColors.transparentColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.vertical,
            Row(
              spacing: 16,
              children: [
                SvgPicture.asset(AppAssets.mapIcon),
                Expanded(
                  child: Text(
                    'Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016',
                    style: AppTextStyles.paragraphStyle.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            16.vertical,
            Row(
              spacing: 16,
              children: [
                Image.asset(AppAssets.gasStationIcon, height: 20, width: 20),
                Expanded(
                  child: Text(
                    'gaseous fuels',
                    style: AppTextStyles.paragraphStyle.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            16.vertical,
            Text("Status", style: AppTextStyles.regularStyle),
            16.vertical,
            OrderStatusLabel(
              status: status!,
              onTap: () => controller.showStatusBottomSheet(context),
            ),
            16.vertical,
            Text("Company", style: AppTextStyles.regularStyle),
            16.vertical,
            Row(
              spacing: 16,
              children: [
                Image.network(
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                  "https://upload.wikimedia.org/wikipedia/en/thumb/e/e8/Shell_logo.svg/1200px-Shell_logo.svg.png",
                ),
                Text(
                  "Pakistan Petroleum Limited",
                  style: AppTextStyles.captionStyle.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            16.vertical,
            Text("Date", style: AppTextStyles.regularStyle),
            16.vertical,
            Row(
              spacing: 16,
              children: [
                SvgPicture.asset(
                  height: 20,
                  fit: BoxFit.cover,
                  width: 20,
                  AppAssets.clockIcon,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                Text("Oct 26 2024", style: AppTextStyles.captionStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
