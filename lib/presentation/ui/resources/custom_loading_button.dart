// created by FAMZY CodeWorks

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rehan_trader_website/presentation/constants/app_constants.dart';

class CustomLoadingButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final bool isSmallScreen;

  const CustomLoadingButton({
    super.key,
    this.text,
    this.child,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.width,
    this.height,
    required this.isSmallScreen,
  }) : assert(
         child != null || text != null,
         'Must provide either child or text',
       );

  @override
  Widget build(BuildContext context) {
    final buttonChild =
        child ??
        Text(
          text!,
          style: AppConstants.elevatedButtonTextStyle.copyWith(
            fontSize: isSmallScreen ? 22.sp : 10.sp,
          ),
        );
    return SizedBox(
      width: width ?? .8.sw,
      height: height ?? 60.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppConstants.primaryTransGColor,

          minimumSize: Size(0.75.sw, .07.sh),
          textStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: isSmallScreen ? 8.sp : 20.sp,
            fontWeight: FontWeight.w600,
          ),
          side: BorderSide(color: Colors.white, width: .5.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 24.h,
                width: 24.w,
                child: SpinKitSpinningLines(color: Colors.white, lineWidth: 2),
              )
            : buttonChild,
      ),
    );
  }
}
