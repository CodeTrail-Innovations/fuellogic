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
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                    ),
                    items:
                        FuelType.values.map((fuel) {
                          return DropdownMenuItem<FuelType>(
                            value: fuel,
                            child: Text(fuel.fuellabel),
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
                                hintText: "Select fuel type",
                                border: OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 16,
                                ),
                              ),
                              items:
                                  FuelUnit.values.map((fuel) {
                                    return DropdownMenuItem<FuelUnit>(
                                      value: fuel,
                                      child: Text(fuel.fuelUnit),
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
              AppFeild(
                hintText: "Oct 26-29 6:00 PM",
                controller: controller.dateController,
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
