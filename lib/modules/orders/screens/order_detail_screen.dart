import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/modules/orders/controllers/order_detail_controller.dart';
import 'package:fuellogic/modules/orders/models/order_model.dart';
import 'package:fuellogic/modules/orders/screens/components/detail_row.dart';
import 'package:fuellogic/modules/orders/screens/components/order_header_card.dart';
import 'package:fuellogic/modules/orders/screens/components/order_status_card.dart';
import 'package:fuellogic/modules/orders/screens/components/schedule_card.dart';
import 'package:fuellogic/modules/orders/screens/components/section_card.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      OrderDetailController(status: order.orderStatus, orderId: order.id),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomAppBar(isSimple: true, height: 40, title: 'Order Details'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: Column(
                  children: [20.vertical, OrderHeaderCard(order: order)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionCard(
                    title: 'Order Information',
                    icon: Icons.info_outline,
                    children: [
                      DetailRow(
                        icon: Icons.article,
                        label: 'Detail',
                        value: order.description,
                        isFirst: true,
                      ),
                      DetailRow(
                        iconAsset: AppAssets.orderIconFilled,
                        label: 'Order total',
                        value: order.orderTotal?.toString() ?? 'N/A',
                      ),
                      DetailRow(
                        iconAsset: AppAssets.orderIconFilled,
                        label: 'DC Book',
                        value: order.dcBook ?? 'N/A',
                      ),
                      DetailRow(
                        iconAsset: AppAssets.mapIcon,
                        label: 'Delivery Location',
                        value: order.location,
                      ),
                      DetailRow(
                        iconAsset: AppAssets.orderIconLinearRed,
                        label: 'Quantity',
                        value: order.quantity,
                        isLast: true,
                      ),
                    ],
                  ),
                  20.vertical,
                  SectionCard(
                    title: 'Order Status',
                    icon: Icons.track_changes,
                    children: [
                      OrderStatusCard(
                        status: order.orderStatus,
                        controller: controller,
                      ),
                    ],
                  ),
                  20.vertical,
                  SectionCard(
                    title: 'Schedule Information',
                    icon: Icons.schedule,
                    children: [ScheduleCard(date: order.date)],
                  ),
                  40.vertical,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
