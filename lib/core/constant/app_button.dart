import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/core/constant/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? btnRadius;
  final Color? btnColor;
  final Color? textColor;
  final bool isOutline;
  final Color? borderColor;
  final double? borderWidth;
  final double height;

  const AppButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.isLoading = false,
    this.btnRadius,
    this.btnColor,
    this.textColor,
    this.isOutline = false,
    this.borderColor,
    this.borderWidth,
    this.height = 65,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool showIcon = screenWidth > 300;

    return InkWell(
      onTap: isLoading ? null : onPressed,
      borderRadius: BorderRadius.circular(btnRadius ?? 16),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color:
              isOutline
                  ? Colors.transparent
                  : (btnColor ?? AppColors.primaryColor),
          borderRadius: BorderRadius.circular(btnRadius ?? 16),
          border:
              isOutline
                  ? Border.all(
                    color: borderColor ?? (btnColor ?? AppColors.primaryColor),
                    width: borderWidth ?? 1.0,
                  )
                  : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null && showIcon && !isLoading)
              Icon(
                icon,
                size: 16,
                color:
                    isOutline
                        ? (borderColor ?? (btnColor ?? AppColors.primaryColor))
                        : (textColor ?? Colors.white),
              ),
            if (icon != null && showIcon && !isLoading)
              const SizedBox(width: 8),
            if (isLoading)
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(
                    isOutline
                        ? (borderColor ?? (btnColor ?? AppColors.primaryColor))
                        : (textColor ?? Colors.white),
                  ),
                ),
              )
            else
              Text(
                text,
                style: AppTextStyles.regularStyle.copyWith(
                  color:
                      isOutline
                          ? (borderColor ??
                              (btnColor ?? AppColors.primaryColor))
                          : (textColor ?? Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
