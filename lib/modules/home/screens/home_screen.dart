import 'package:flutter/material.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/modules/profile/controllers/profile_controller.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              children: [
                AppButton(text: "logout", onPressed: controller.logout),
                // OrderCard(status: OrderStatus.pending),
                // OrderCard(status: OrderStatus.approved),
                // OrderCard(status: OrderStatus.onTheWay),
                // OrderCard(status: OrderStatus.delivered),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
