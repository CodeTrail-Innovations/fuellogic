import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/constant/app_field.dart';

class CreateOrderScreen extends StatelessWidget {
  const CreateOrderScreen({super.key});

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
                hintText:
                    "Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016",
              ),
              Text("Choose fuel type", style: AppTextStyles.regularStyle),
              AppFeild(hintText: "gaseous fuels"),
              Text("Choose company", style: AppTextStyles.regularStyle),
              AppFeild(hintText: "Pakistan Petroleum Limited"),
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
                        AppFeild(hintText: "Pakistan Petroleum Limited"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Unit", style: AppTextStyles.regularStyle),
                        AppFeild(hintText: "liters"),
                      ],
                    ),
                  ),
                ],
              ),
              Text("Choose date", style: AppTextStyles.regularStyle),
              AppFeild(hintText: "Oct 26-29 6:00 PM"),
            ],
          ),
        ),
      ),
    );
  }
}
