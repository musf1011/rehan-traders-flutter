import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rehan_trader_website/core/constants/app_constants.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final bool obscureText;
  final bool isPasswordHidden;
  final VoidCallback? toggleVisibility;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;
  final int maxLines;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final bool isSmallScreen;
  final IconData? icon;
  final Widget? suffixIcon;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.isSmallScreen,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isPasswordHidden = true,
    this.toggleVisibility,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.onSaved,
    this.inputFormatters,
    this.icon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: controller == null ? initialValue : null,
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      obscureText: obscureText && isPasswordHidden,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      inputFormatters: inputFormatters,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        errorStyle: TextStyle(
          color: AppConstants.errorColor,
          backgroundColor: AppConstants.whiteColorP3,
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: AppConstants.secondaryTransGColor,
          fontSize: isSmallScreen ? 16.sp : 6.sp,
        ),
        hintText: hint,
        hintStyle: TextStyle(color: AppConstants.whiteColorP5),

        icon: Icon(
          obscureText ? Icons.lock : icon,
          color: AppConstants.primaryTransGColor,
          size: isSmallScreen ? 20.sp : 10.sp,
        ),
        suffixIcon: toggleVisibility != null
            ? IconButton(
                onPressed: toggleVisibility,
                icon: Icon(
                  isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                  color: isPasswordHidden
                      ? Colors.grey
                      : AppConstants.tertiaryColor,
                ),
              )
            : suffixIcon,

        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppConstants.tertiaryColor),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppConstants.errorColor),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}
