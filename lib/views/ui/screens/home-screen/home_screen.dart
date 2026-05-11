// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:rehan_trader_website/constants/app_constants.dart';
// import 'package:rehan_trader_website/ui/widgets/custom_image_view.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // CustomImageView(
//         //   imagePath: AppConstants.businessDisplayImage,
//         //   width: 1.sw,
//         // ),
//         Text('HELLO', style: TextStyle(color: AppConstants.famzyGold)),
//         ...List.generate(
//           15,
//           (index) => Container(height: 10.h, width: 1.sw, color: Colors.black),
//         ),
//         Text('HELOO'),
//         SizedBox(height: 10.h),

//         Container(height: 100.h, width: 1.sw, color: Colors.black),
//         SizedBox(height: 10.h),

//         Container(height: 100.h, width: 1.sw, color: Colors.black),
//         SizedBox(height: 10.h),

//         Container(height: 100.h, width: 1.sw, color: Colors.black),
//         SizedBox(height: 10.h),

//         Container(height: 100.h, width: 1.sw, color: Colors.black),
//         SizedBox(height: 10.h),

//         Container(height: 100.h, width: 1.sw, color: Colors.black),
//         SizedBox(height: 10.h),

//         Container(height: 100.h, width: 1.sw, color: Colors.black),
//         SizedBox(height: 10.h),

//         Container(height: 100.h, width: 1.sw, color: Colors.black),
//         SizedBox(height: 10.h),

//         Container(height: 100.h, width: 1.sw, color: Colors.black),
//         SizedBox(height: 10.h),

//         Container(height: 100.h, width: 1.sw, color: Colors.black),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rehan_trader_website/core/constants/app_constants.dart';
import 'package:rehan_trader_website/view-models/controllers/screen_size_controller.dart';
import 'package:rehan_trader_website/views/widgets/custom_image_view.dart';
import 'package:rehan_trader_website/views/widgets/social_media_buttons_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen controller
    // final screenController = Provider.of<ScreenSizeController>(context);
    // final isSmallScreen = screenController.isSmallScreen;
    final isSmallScreen = ResponsiveHelper.isMobile(context);
    return SizedBox(
      height: isSmallScreen ? .9.sh : .97.sh,
      width: 1.sw,

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stack(
            //   child: CustomImageView(
            //     imagePath: AppConstants.businessDisplayImage,
            //     width: 1.sw,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Stack(
              // alignment: Alignment.centerLeft,
              children: [
                // 1. The Background Image
                CustomImageView(
                  imagePath: AppConstants.businessDisplayImage,
                  width: 1.sw,
                  // height: .5.sh,
                  height: isSmallScreen ? 300.h : 580.h,
                  fit: BoxFit.cover,
                ),

                // 2. The Dark Overlay (Crucial for text readability)
                Container(
                  width: 1.sw,
                  height: isSmallScreen ? 300.h : 580.h,
                  decoration: BoxDecoration(color: AppConstants.blackColorP7),
                ),

                // 3. The Content Layer
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w), //was 20.w
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "We Trades with Real Traders",
                        style: TextStyle(
                          color: AppConstants.whiteColorP7,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          decorationStyle: TextDecorationStyle.wavy,
                          decorationColor: AppConstants.whiteColorP7,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: 0.7
                            .sw, // Constrain width so text wraps like the image
                        child: Text(
                          "Our Mission is to empower traders with the tools and insights they need to succeed in the financial markets.",
                          style: TextStyle(
                            color: AppConstants.whiteColorP5,
                            fontSize: 10.sp,
                            height: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // 4. Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: .end,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstants.primaryColor,
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w, // was 20.w
                                vertical: 12.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: const Text(
                              "Our Services",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "See How It Works",
                              style: TextStyle(
                                color: AppConstants.primaryColor,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: AppConstants.primaryColor,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 10.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),

                          SizedBox(width: 10.w),

                          isSmallScreen
                              ? SizedBox.shrink()
                              : SocialMediaButtons(),
                        ],
                      ),
                      isSmallScreen
                          ? SocialMediaButtons()
                          : SizedBox.shrink(), // Show social media buttons below on small screens
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'HELLO',
                style: TextStyle(
                  color: AppConstants.famzyGold,
                  fontSize: 24.sp,
                ),
              ),
            ),
            // GridView for products/items
            GridView.builder(
              shrinkWrap: true, // Important for using inside Column
              physics:
                  const NeverScrollableScrollPhysics(), // Disable inner scrolling
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 10, // Horizontal spacing between items
                mainAxisSpacing: 10, // Vertical spacing between items
                childAspectRatio: 0.8, // Height/width ratio of each item
              ),
              itemCount: 10, // Number of items
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppConstants.famzyGold,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inventory, size: 50.sp),
                      SizedBox(height: 10.h),
                      Text('Item ${index + 1}'),
                    ],
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('More Content', style: TextStyle(fontSize: 24)),
            ),
            ...List.generate(
              5,
              (index) => Container(
                height: 100.h,
                width: 1.sw,
                color: Colors.black,
                margin: EdgeInsets.only(bottom: 10.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
