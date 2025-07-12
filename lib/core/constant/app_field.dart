import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:svg_flutter/svg.dart';

class AppFeild extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final bool isSearchField;
  final String hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  final String? prefixImage;
  final double? iconSize;
  final Color? iconColor;
  final bool feildSideClr;
  final bool feildFocusClr;
  final Color? feildClr;
  final double radius;
  final double height;
  final Color? hintTextColor;
  final Color? fieldTextColor;
  final String? suffixImage;
  final VoidCallback? onSuffixTap;
  final bool isRating;
  final bool isTextarea;
  final bool enabled;
  final TextCapitalization textCapitalization;

  const AppFeild({
    super.key,
    this.controller,
    this.isPasswordField,
    this.fieldKey,
    required this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType,
    this.prefixImage,
    this.iconSize,
    this.iconColor,
    this.feildSideClr = false,
    this.feildFocusClr = false,
    this.feildClr,
    this.radius = 12,
    this.isSearchField = false,
    this.height = 55,
    this.hintTextColor,
    this.fieldTextColor,
    this.suffixImage,
    this.onSuffixTap,
    this.isRating = false,
    this.isTextarea = false,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  AppFeildState createState() => AppFeildState();
}

class AppFeildState extends State<AppFeild> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isSearchField = widget.isSearchField;
    final enabled = widget.enabled;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color:
            isSearchField
                ? AppColors.transparentColor
                : widget.feildClr ?? AppColors.transparentColor,
        borderRadius: BorderRadius.circular(
          isSearchField ? 100 : widget.radius,
        ),
      ),
      child: TextFormField(
        textCapitalization: widget.textCapitalization,
        enabled: enabled,
        style: AppTextStyles.paragraphStyle.copyWith(
          color:
              isSearchField
                  ? AppColors.whiteColor
                  : widget.fieldTextColor ?? AppColors.blackColor,
        ),
        controller: widget.controller,
        keyboardType:
            widget.isTextarea
                ? TextInputType.multiline
                : widget.isRating
                ? const TextInputType.numberWithOptions(decimal: true)
                : widget.inputType,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        onSaved: widget.onSaved,
        validator: (value) {
          if (widget.validator != null) {
            return widget.validator!(value);
          }
          if (widget.isRating && value != null && value.isNotEmpty) {
            final rating = double.tryParse(value);
            if (rating == null || rating > 5 || rating < 0) {
              return 'Rating must be between 0 and 5';
            }
          }
          return null;
        },
        onFieldSubmitted: widget.onFieldSubmitted,
        inputFormatters:
            widget.isRating
                ? [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}')),
                  _MaxValueInputFormatter(5.0),
                ]
                : null,
        minLines: widget.isTextarea ? 3 : 1,
        maxLines: widget.isTextarea ? null : 1,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: (widget.height - 24) / 2,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  isSearchField ? AppColors.whiteColor : AppColors.blackColor,
            ),
            borderRadius: BorderRadius.circular(
              isSearchField ? 100 : widget.radius,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              isSearchField ? 100 : widget.radius,
            ),
            borderSide: BorderSide(
              color:
                  isSearchField
                      ? AppColors.whiteColor
                      : widget.feildSideClr
                      ? AppColors.blackColor
                      : AppColors.blackColor.withCustomOpacity(.2),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              isSearchField ? 100 : widget.radius,
            ),
            borderSide: BorderSide(
              color: AppColors.blackColor.withCustomOpacity(.2),
            ),
          ),
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color:
                isSearchField
                    ? AppColors.whiteColor.withCustomOpacity(0.8)
                    : widget.hintTextColor ??
                        AppColors.blackColor.withCustomOpacity(.35),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon:
              isSearchField || widget.prefixImage != null
                  ? Padding(
                    padding: const EdgeInsets.all(12.0).copyWith(left: 16),
                    child: SvgPicture.asset(
                      AppAssets.searchIcon,
                      width: widget.iconSize ?? 24,
                      height: widget.iconSize ?? 24,
                      fit: BoxFit.contain,

                      colorFilter:
                          widget.prefixImage != null
                              ? ColorFilter.mode(
                                widget.iconColor ?? AppColors.blackColor,
                                BlendMode.srcIn,
                              )
                              : null,

                      // ignore: deprecated_member_use
                      color:
                          isSearchField
                              ? AppColors.whiteColor
                              : widget.iconColor,
                    ),
                  )
                  : null,
          suffixIcon:
              widget.isPasswordField == true
                  ? GestureDetector(
                    onTap:
                        enabled
                            ? () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            }
                            : null,
                    child: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      size: widget.iconSize,
                      color:
                          _obscureText
                              ? AppColors.mainColor
                              : AppColors.blackColor,
                    ),
                  )
                  : widget.suffixImage != null
                  ? GestureDetector(
                    onTap: enabled ? widget.onSuffixTap : null,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0).copyWith(right: 16),
                      child: SvgPicture.asset(
                        widget.suffixImage!,
                        width: widget.iconSize ?? 24,
                        height: widget.iconSize ?? 24,
                        fit: BoxFit.contain,
                        // ignore: deprecated_member_use
                        color: isSearchField ? AppColors.whiteColor : null,
                      ),
                    ),
                  )
                  : null,
        ),
      ),
    );
  }
}

class _MaxValueInputFormatter extends TextInputFormatter {
  final double maxValue;

  _MaxValueInputFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final value = double.tryParse(newValue.text);
    if (value == null || value > maxValue) {
      return oldValue;
    }

    return newValue;
  }
}
