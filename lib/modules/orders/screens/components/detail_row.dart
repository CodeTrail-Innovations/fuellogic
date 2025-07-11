import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:svg_flutter/svg.dart';

class DetailRow extends StatelessWidget {
  final IconData? icon;
  final String? iconAsset;
  final String label;
  final String value;
  final bool isFirst;
  final bool isLast;

  const DetailRow({
    super.key,
    this.icon,
    this.iconAsset,
    required this.label,
    required this.value,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: isFirst ? 0 : 16, bottom: isLast ? 0 : 16),
      decoration: BoxDecoration(
        border:
            isLast
                ? null
                : Border(
                  bottom: BorderSide(
                    color: AppColors.blackColor.withCustomOpacity(0.1),
                    width: 1,
                  ),
                ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withCustomOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                icon != null
                    ? Icon(icon, size: 16, color: AppColors.primaryColor)
                    : SvgPicture.asset(
                      iconAsset!,
                      height: 16,
                      width: 16,
                      colorFilter: ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.captionStyle.copyWith(
                    color: AppColors.blackColor.withCustomOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppTextStyles.paragraphStyle.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
