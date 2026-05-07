//created by: FAMZY Codeworks

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rehan_trader_website/core/constants/app_constants.dart';
import 'package:rehan_trader_website/view-models/controllers/screen_size_controller.dart';
import 'package:rehan_trader_website/views/ui/screens/dashboard-screen/dashboard_screen.dart';
import 'package:rehan_trader_website/views/widgets/background_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('*********splash Screen started');
    Timer(const Duration(seconds: 5), () async {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // bool isRememberMeChecked = prefs.getBool('isRememberMeChecked') ?? false;

      debugPrint('*********splash Screen ready to navigate to home screen');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              // isRememberMeChecked ? DashboardScreen() :
              // LoginScreen()
              // HomeScreen(),
              DashboardScreen(),
        ),
      );
    });
  }

  @override
  void didChangeDependencies() {
    // PRE-CACHE: Loads the optimized background image into memory
    // immediately to prevent the "white flash" or frame skipping.
    precacheImage(const AssetImage(AppConstants.splashScreenBgImage), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenController = Provider.of<ScreenSizeController>(context);
    screenController.updateScreenSize(context);
    final isSmallScreen = screenController.isSmallScreen;
    return
    // AppAuthBackground(
    //   child:
    BackgroundWrapper(
      imagePath: AppConstants.appBgImage,

      child: Column(
        mainAxisAlignment: .start,
        children: [
          // SizedBox(
          //   height: .2.sh,
          //   width: .5.sw,
          //   child: CustomImageView(
          //     imagePath: AppConstants.companyLogo,
          //     height: .1.sh,
          //     width: .2.sw,

          //     fit: BoxFit.cover,
          //   ),
          // ),
          SizedBox(height: isSmallScreen ? 150.h : 20.h),
          Image.asset(
            AppConstants.companyLogo,
            height: isSmallScreen ? .25.sh : .5.sh,
            width: isSmallScreen ? .4.sw : .25.sw,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 10.h),
          Text(
            'WELCOME',
            textAlign: .center,
            style: GoogleFonts.poppins(
              fontSize: isSmallScreen ? 36.sp : 24.sp,
              fontWeight: FontWeight.bold,
              color: AppConstants.primaryColor,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 20.h),
          SpinKitSpinningLines(
            color: AppConstants.primaryColor,
            size: 70.r,
            lineWidth: 2.r,
          ),
        ],
      ),
    );
    // );
  }
}
