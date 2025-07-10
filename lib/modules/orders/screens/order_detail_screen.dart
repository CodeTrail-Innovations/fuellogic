import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/home/screens/components/order_status_label.dart';
import 'package:fuellogic/modules/orders/controllers/order_detail_controller.dart';
import 'package:fuellogic/modules/orders/models/order_model.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
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
                  children: [
                    20.vertical,
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blackColor.withCustomOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor
                                      .withCustomOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.receipt_long,
                                  color: AppColors.primaryColor,
                                  size: 24,
                                ),
                              ),
                              12.horizontal,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order #${order.id}',
                                      style: AppTextStyles.regularStyle
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blackColor,
                                            fontSize: 18,
                                          ),
                                    ),
                                    4.vertical,
                                    Text(
                                      'Fuel Delivery Order',
                                      style: AppTextStyles.captionStyle
                                          .copyWith(
                                            color: AppColors.blackColor
                                                .withCustomOpacity(0.6),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionCard(
                    title: 'Order Information',
                    icon: Icons.info_outline,
                    children: [
                      _buildDetailRow(
                        icon: Icons.article,
                        label: 'Detail',
                        value: order.description,
                        isFirst: true,
                      ),
                      _buildDetailRow(
                        iconAsset: AppAssets.mapIcon,
                        label: 'Delivery Location',
                        value: order.location,
                      ),
                      _buildDetailRow(
                        iconAsset: AppAssets.orderIconLinearRed,
                        label: 'Quantity',
                        value: order.quantity,
                        isLast: true,
                      ),
                    ],
                  ),
                  20.vertical,
                  _buildSectionCard(
                    title: 'Order Status',
                    icon: Icons.track_changes,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _getStatusColor(
                            order.orderStatus,
                          ).withCustomOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _getStatusColor(
                              order.orderStatus,
                            ).withCustomOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            OrderStatusLabel(
                              status: order.orderStatus,
                              onTap: () {
                                if (order.orderStatus == OrderStatus.approved ||
                                    order.orderStatus == OrderStatus.onTheWay) {
                                  controller.showStatusBottomSheet(context);
                                }
                              },
                            ),
                            12.vertical,
                            _buildStatusProgress(order.orderStatus),
                          ],
                        ),
                      ),
                    ],
                  ),

                  20.vertical,

                  _buildSectionCard(
                    title: 'Schedule Information',
                    icon: Icons.schedule,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryColor.withCustomOpacity(0.05),
                              AppColors.primaryColor.withCustomOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withCustomOpacity(
                                  0.2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: SvgPicture.asset(
                                AppAssets.clockIcon,
                                height: 20,
                                width: 20,
                                colorFilter: ColorFilter.mode(
                                  AppColors.primaryColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            16.horizontal,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Scheduled Date & Time',
                                    style: AppTextStyles.captionStyle.copyWith(
                                      color: AppColors.blackColor
                                          .withCustomOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  4.vertical,
                                  Text(
                                    order.date,
                                    style: AppTextStyles.regularStyle.copyWith(
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withCustomOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.mainColor.withCustomOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: AppColors.mainColor, size: 20),
                12.horizontal,
                Text(
                  title,
                  style: AppTextStyles.regularStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    IconData? icon,
    String? iconAsset,
    required String label,
    required String value,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Container(
      padding: EdgeInsets.only(top: isFirst ? 0 : 16, bottom: isLast ? 0 : 16),
      decoration: BoxDecoration(
        border:
            isLast
                ? null
                : Border(
                  bottom: BorderSide(
                    color: AppColors.blackColor.withCustomOpacity(0.1),
                    width: 1,
                  ),
                ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withCustomOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                icon != null
                    ? Icon(icon, size: 16, color: AppColors.primaryColor)
                    : SvgPicture.asset(
                      iconAsset!,
                      height: 16,
                      width: 16,
                      colorFilter: ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
          ),
          16.horizontal,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.captionStyle.copyWith(
                    color: AppColors.blackColor.withCustomOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                4.vertical,
                Text(
                  value,
                  style: AppTextStyles.paragraphStyle.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
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
