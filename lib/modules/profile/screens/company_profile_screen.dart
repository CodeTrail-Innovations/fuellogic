import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/constant/app_field.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/profile/controllers/profile_controller.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class CompanyProfileScreen extends StatelessWidget {
  CompanyProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(isSimple: true, height: 55, title: 'Profile'),
        body:
            controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : controller.userData.value == null
                ? const Center(child: Text('User data not available'))
                : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.vertical,
                      Text("Your Name", style: AppTextStyles.regularStyle),
                      AppFeild(
                        hintText: "Enter Name",
                        controller: controller.displayNameController,
                      ),
                      8.vertical,
                      Text("Your mail", style: AppTextStyles.regularStyle),
                      AppFeild(
                        enabled: false,
                        hintText: controller.userData.value!.email,
                      ),
                      8.vertical,
                      controller.userData.value!.role == UserRole.company
                          ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              Text(
                                "Phone Number",
                                style: AppTextStyles.regularStyle,
                              ),
                              AppFeild(
                                hintText: "Phone Number",
                                controller: controller.phoneNumberController,
                                inputType: TextInputType.numberWithOptions(),
                              ),
                              8.vertical,
                              Text(
                                "Address",
                                style: AppTextStyles.regularStyle,
                              ),
                              AppFeild(
                                hintText: "Address",
                                controller: controller.addressController,
                              ),
                            ],
                          )
                          : SizedBox.shrink(),

                      8.vertical,
                      Obx(
                        () => AppButton(
                          isLoading: controller.isLoading.value,
                          text: "Save Changes",
                          onPressed: () => controller.saveProfileChanges(),
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
