import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/helper/constants/keys.dart';
import 'package:fuellogic/helper/utils/hive_utils.dart';
import 'package:fuellogic/modules/orders/controllers/order_detail_controller.dart';
import 'package:fuellogic/modules/orders/models/order_model.dart';
import 'package:fuellogic/modules/orders/screens/components/detail_row.dart';
import 'package:fuellogic/modules/orders/screens/components/order_header_card.dart';
import 'package:fuellogic/modules/orders/screens/components/order_status_card.dart';
import 'package:fuellogic/modules/orders/screens/components/schedule_card.dart';
import 'package:fuellogic/modules/orders/screens/components/section_card.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class OrderDetailScreen extends StatelessWidget {
  OrderDetailScreen({super.key, required this.order});

  final OrderModel order;

  final role = HiveBox().getValue(key: roleKey);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      OrderDetailController(status: order.orderStatus, orderId: order.id, order: order),
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
                      // Order Total - Editable
                      InkWell(
                        onTap: () {

                          if(role == adminRoleKey){
                            controller.showEditDialog(
                              field: 'orderTotal',
                              title: 'Edit Order Total',
                              initialValue: controller.order.value.orderTotal?.toString() ?? '',
                            );
                          }

                        },
                        child: Obx(()=>DetailRow(
                          iconAsset: AppAssets.orderIconFilled,
                          label: 'Order total',
                          value: controller.order.value.orderTotal?.toString() ?? 'N/A',
                          suffixIcon: role == adminRoleKey ? Icons.edit : null,
                        )),
                      ),

// DC Book - Editable
                      InkWell(
                        onTap: () {

                          if(role  == adminRoleKey){
                            controller.showEditDialog(
                              field: 'dcBook',
                              title: 'Edit DC Book Number',
                              initialValue: controller.order.value.dcBook ?? '',
                            );
                          }


                        },
                        child: Obx(()=>DetailRow(
                          iconAsset: AppAssets.orderIconFilled,
                          label: 'DC Book',
                          value: controller.order.value.dcBook ?? 'N/A',
                          suffixIcon: role  == adminRoleKey ? Icons.edit : null,
                        )),
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
                    title: 'Customer Information',
                    icon: Icons.person_outline,
                    children: [
                      Obx(() {
                        final company = controller.companyData.value;
                        if (company == null) return const Text('Loading company info...');
                        return Column(
                          children: [
                            DetailRow(
                              icon: Icons.business,
                              label: 'Company Name',
                              value: company.displayName,
                              isFirst: true,
                            ),
                            DetailRow(
                              icon: Icons.phone,
                              label: 'Company Email',
                              value: company.email,
                            ),
                          ],
                        );
                      }),
                      10.vertical,
                      if (controller.order.value.driverId != null && controller.order.value.driverId!.isNotEmpty)
                        Obx(() {
                          final driver = controller.driverData.value;

                          if (driver == null) {
                            return const Text('Loading driver info...');
                          }

                          return Column(
                            children: [
                              DetailRow(
                                icon: Icons.local_shipping,
                                label: 'Driver Name',
                                value: driver.displayName,
                                isFirst: true,
                              ),
                              DetailRow(
                                icon: Icons.phone_android,
                                label: 'Driver Email',
                                value: driver.email ?? 'N/A',
                                isLast: true,
                              ),
                            ],
                          );
                        })
                      else
                        const SizedBox.shrink(), // or nothing if no driver

                    ],
                  ),

                  20.vertical,
                  SectionCard(
                    title: 'Order Status',
                    icon: Icons.track_changes,
                    children: [
                      Obx(()=>OrderStatusCard(
                        status: controller.order.value.orderStatus,
                        controller: controller,
                      )),
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
