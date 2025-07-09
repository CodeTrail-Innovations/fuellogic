import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/constant/app_field.dart';
import 'package:fuellogic/modules/orders/controllers/create_order_controller.dart';
import 'package:get/get.dart';

class CreateOrderScreen extends StatelessWidget {
  CreateOrderScreen({super.key});
  final controller = Get.put(CreateOrderController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.vertical,
              Text(
                "Create order",
                style: AppTextStyles.largeStyle.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              Text("Enter detail of order", style: AppTextStyles.regularStyle),
              AppFeild(
                controller: controller.descriptionController,
                isTextarea: true,
                hintText: "Enter item names, data, and delivery instructions",
              ),
              Text("Choose location", style: AppTextStyles.regularStyle),
              AppFeild(
                controller: controller.locationController,
                hintText:
                    "Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016",
              ),
              Text("Enter Quantity", style: AppTextStyles.regularStyle),
              AppFeild(
                height: 55,
                controller: controller.quantityController,
                hintText: "Pakistan Petroleum Limited",
                inputType: TextInputType.numberWithOptions(),
              ),
              Text("Choose date", style: AppTextStyles.regularStyle),
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    controller.dateController.text =
                        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                  }
                },
                child: AbsorbPointer(
                  child: AppFeild(
                    hintText: "Select date",
                    controller: controller.dateController,
                  ),
                ),
              ),
              Obx(
                () => AppButton(
                  text: "Create order",
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.createOrder();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
