import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/home/screens/components/order_status_label.dart';
import 'package:fuellogic/modules/orders/controllers/order_detail_controller.dart';
import 'package:fuellogic/modules/orders/models/order_model.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      OrderDetailController(status: order.orderStatus, orderId: order.id),
    );

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
                Icon(Icons.article, size: 20, color: AppColors.primaryColor),
                Expanded(
                  child: Text(
                    order.description,
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
                SvgPicture.asset(AppAssets.mapIcon),
                Expanded(
                  child: Text(
                    order.location,
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
              status: order.orderStatus,
              onTap: () {
                if (order.orderStatus == OrderStatus.approved ||
                    order.orderStatus == OrderStatus.onTheWay) {
                  controller.showStatusBottomSheet(context);
                }
              },
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
              ],
            ),
            16.vertical,
            Text("Date", style: AppTextStyles.regularStyle),
            16.vertical,
            Row(
              spacing: 16,
              children: [
                SvgPicture.asset(
                  AppAssets.clockIcon,
                  height: 20,
                  width: 20,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                Text(order.date, style: AppTextStyles.captionStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
