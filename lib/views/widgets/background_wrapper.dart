import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rehan_trader_website/core/constants/app_constants.dart';

class BackgroundWrapper extends StatelessWidget {
  final String imagePath;
  final Widget child;

  const BackgroundWrapper({
    super.key,
    required this.imagePath,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppConstants.tertiaryTransGColor,
              AppConstants.blackColorP5,
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
