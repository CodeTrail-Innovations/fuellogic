import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/constant/app_field.dart';
import 'package:fuellogic/modules/profile/controllers/profile_controller.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class CompanyProfileScreen extends StatelessWidget {
  const CompanyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    final user = controller.userData.value;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body:
            controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : user == null
                ? const Center(child: Text('User data not available'))
                : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text("Company Name", style: AppTextStyles.regularStyle),
                      AppFeild(
                        hintText: "Company Name",
                        controller: controller.displayNameController,
                      ),
                      8.vertical,
                      Text("Phone Number", style: AppTextStyles.regularStyle),
                      AppFeild(
                        hintText: "Phone Number",
                        controller: controller.phoneNumberController,
                        inputType: TextInputType.numberWithOptions(),
                      ),
                      8.vertical,
                      Text("Address", style: AppTextStyles.regularStyle),
                      AppFeild(
                        hintText: "Address",
                        controller: controller.addressController,
                      ),
                      8.vertical,
                      AppButton(
                        text: "Save Changes",
                        onPressed: () => controller.saveProfileChanges(),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
