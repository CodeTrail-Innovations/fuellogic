import 'package:flutter/material.dart';
import 'package:fuellogic/helper/extensions/space_extensions.dart';
import 'package:fuellogic/modules/auth/controllers/register_controller.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_field.dart';
import '../../../helper/theme/app_text_styles.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final controller = Get.find<RegisterController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Text(
                'Enter your email address and we\'ll send you a link to reset your password.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              Text("Email", style: AppTextStyles.labelStyle),
              8.vertical,

              AppField(
                hintText: 'Enter your email',
                controller: controller.emailController,
                validator: controller.validateEmail,
              ),
              const SizedBox(height: 24),
              Obx(() => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                  if (_formKey.currentState!.validate()) {
                    controller.resetPassword();
                  }
                },
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Send Reset Link'),
              )),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Back to Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
