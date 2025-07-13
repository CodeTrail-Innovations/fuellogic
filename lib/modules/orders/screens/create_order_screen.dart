import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/constant/app_field.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/helper/constants/keys.dart';
import 'package:fuellogic/helper/utils/hive_utils.dart';
import 'package:fuellogic/modules/orders/controllers/create_order_controller.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class CreateOrderScreen extends StatelessWidget {
  CreateOrderScreen({super.key});
  final controller = Get.put(CreateOrderController());

  final role = HiveBox().getValue(key: roleKey);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
            role == UserRole.company.value
                ? CustomAppBar(isSimple: true, height: 55)
                : null,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              6.vertical,
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
                textCapitalization: TextCapitalization.sentences,
              ),
              Text("Choose location", style: AppTextStyles.regularStyle),
              AppFeild(
                controller: controller.locationController,
                hintText: "12A City Mall, Jail Road, Lahore - 52334",
                textCapitalization: TextCapitalization.words,
              ),
              Text("Enter Quantity", style: AppTextStyles.regularStyle),
              AppFeild(
                controller: controller.quantityController,
                hintText: "e.g. 500 ltr or 30 Pieces",
                inputType: TextInputType.text,
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
              10.vertical,
              Obx(
                () => AppButton(
                  text: "Create order",
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.createOrder();
                  },
                ),
              ),
              20.vertical,
            ],
          ),
        ),
      ),
    );
  }
}
