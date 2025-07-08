import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/modules/company/controllers/report_controller.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class AllDriverScreen extends StatelessWidget {
  final controller = Get.put(ReportController());

  AllDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryColor,
                ),
              ),
            );
          }

          if (controller.driversList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 80,
                    color: AppColors.whiteColor.withCustomOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No drivers found',
                    style: TextStyle(
                      color: AppColors.whiteColor.withCustomOpacity(0.7),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add drivers to see them here',
                    style: TextStyle(
                      color: AppColors.whiteColor.withCustomOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: controller.driversList.length,
                  itemBuilder: (context, index) {
                    final driver = controller.driversList[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blackColor.withCustomOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryColor.withCustomOpacity(
                                0.3,
                              ),
                              width: 2,
                            ),
                          ),
                          child:
                              driver.photoURL.isNotEmpty
                                  ? CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage(
                                      driver.photoURL,
                                    ),
                                    backgroundColor: AppColors.primaryColor
                                        .withCustomOpacity(0.1),
                                  )
                                  : CircleAvatar(
                                    radius: 28,
                                    backgroundColor: AppColors.primaryColor
                                        .withCustomOpacity(0.1),
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.primaryColor,
                                      size: 28,
                                    ),
                                  ),
                        ),
                        title: Text(
                          driver.displayName,
                          style: AppTextStyles.regularStyle,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            driver.email,
                            style: AppTextStyles.paragraphStyle,
                          ),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withCustomOpacity(
                              0.1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.primaryColor.withCustomOpacity(
                                0.3,
                              ),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'Active',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
