import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/constant/app_field.dart';
import 'package:fuellogic/core/enums/enum.dart';
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
              Text("Choose location", style: AppTextStyles.regularStyle),
              AppFeild(
                controller: controller.locationController,
                hintText:
                    "Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016",
              ),

              Text("Choose fuel type", style: AppTextStyles.regularStyle),
              StatefulBuilder(
                builder: (context, setState) {
                  return DropdownButtonFormField<FuelType>(
                    value: controller.fuelType.value,
                    decoration: InputDecoration(
                      hintText: "Select fuel type",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppColors.blackColor.withCustomOpacity(0.2),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppColors.blackColor.withCustomOpacity(0.2),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppColors.blackColor.withCustomOpacity(0.2),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                    ),
                    items:
                        FuelType.values.map((fuel) {
                          return DropdownMenuItem<FuelType>(
                            value: fuel,
                            child: Text(fuel.value),
                          );
                        }).toList(),
                    onChanged: (FuelType? newValue) {
                      if (newValue != null) {
                        controller.fuelType.value = newValue;
                      }
                    },
                  );
                },
              ),

              Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        Text(
                          "Enter Quantity",
                          style: AppTextStyles.regularStyle,
                        ),
                        AppFeild(
                          height: 55,
                          controller: controller.quantityController,
                          hintText: "Pakistan Petroleum Limited",
                          inputType: TextInputType.numberWithOptions(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Unit", style: AppTextStyles.regularStyle),
                        StatefulBuilder(
                          builder: (context, setState) {
                            return DropdownButtonFormField<FuelUnit>(
                              value: controller.fuelUnit.value,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: AppColors.blackColor
                                        .withCustomOpacity(0.2),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: AppColors.blackColor
                                        .withCustomOpacity(0.2),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: AppColors.blackColor
                                        .withCustomOpacity(0.2),
                                  ),
                                ),
                                hintText: "Select fuel type",
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 16,
                                ),
                              ),
                              items:
                                  FuelUnit.values.map((fuel) {
                                    return DropdownMenuItem<FuelUnit>(
                                      value: fuel,
                                      child: Text(fuel.value),
                                    );
                                  }).toList(),
                              onChanged: (FuelUnit? newValue) {
                                if (newValue != null) {
                                  controller.fuelUnit.value = newValue;
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
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
              AppButton(
                text: "Create order",
                onPressed: () {
                  controller.createOrder();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
