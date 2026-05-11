// // // //created by: FAMZY CodeWorks

// // // import 'package:flutter/material.dart';

// // // class ScreenSizeController extends ChangeNotifier {
// // //   bool _isSmallScreen = false;
// // //   double _screenWidth = 0;
// // //   double _screenHeight = 0;

// // //   bool get isSmallScreen => _isSmallScreen;
// // //   double get screenWidth => _screenWidth;
// // //   double get screenHeight => _screenHeight;

// // //   void updateScreenSize(BuildContext context) {
// // //     final width = MediaQuery.of(context).size.width;
// // //     final height = MediaQuery.of(context).size.height;

// // //     final newIsSmallScreen = width < 700;

// // //     if (_screenWidth != width || _isSmallScreen != newIsSmallScreen) {
// // //       _screenWidth = width;
// // //       _screenHeight = height;
// // //       _isSmallScreen = newIsSmallScreen;
// // //       notifyListeners();
// // //     }
// // //   }
// // // }

// // // screen_size_controller.dart
// // import 'package:flutter/material.dart';

// // class ScreenSizeController extends ChangeNotifier {
// //   bool _isSmallScreen = false;
// //   double _screenWidth = 0;
// //   double _screenHeight = 0;

// //   // Flag to prevent updates during build
// //   bool _isUpdating = false;

// //   bool get isSmallScreen => _isSmallScreen;
// //   double get screenWidth => _screenWidth;
// //   double get screenHeight => _screenHeight;

// //   // Call this method safely (not during build)
// //   void updateScreenSize(BuildContext context) {
// //     if (_isUpdating) return;

// //     _isUpdating = true;

// //     // Schedule after current frame to avoid build phase issues
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       final width = MediaQuery.of(context).size.width;
// //       final height = MediaQuery.of(context).size.height;
// //       final newIsSmallScreen = width < 700;

// //       if (_screenWidth != width || _isSmallScreen != newIsSmallScreen) {
// //         _screenWidth = width;
// //         _screenHeight = height;
// //         _isSmallScreen = newIsSmallScreen;
// //         notifyListeners();
// //       }

// //       _isUpdating = false;
// //     });
// //   }

// //   // Direct update method for LayoutBuilder
// //   void updateFromConstraints(BoxConstraints constraints) {
// //     final width = constraints.maxWidth;
// //     final height = constraints.maxHeight;
// //     final newIsSmallScreen = width < 700;

// //     if (_screenWidth != width || _isSmallScreen != newIsSmallScreen) {
// //       _screenWidth = width;
// //       _screenHeight = height;
// //       _isSmallScreen = newIsSmallScreen;
// //       notifyListeners();
// //     }
// //   }
// // }

// //created by: FAMZY CodeWorks

// import 'package:flutter/material.dart';

// class ScreenSizeController extends ChangeNotifier {
//   bool _isSmallScreen = false;

//   double _screenWidth = 0;

//   double _screenHeight = 0;

//   bool get isSmallScreen => _isSmallScreen;

//   double get screenWidth => _screenWidth;

//   double get screenHeight => _screenHeight;

//   void updateScreenSize({required double width, required double height}) {
//     final bool newIsSmallScreen = width < 700;

//     bool shouldNotify = false;

//     if (_screenWidth != width) {
//       _screenWidth = width;
//       shouldNotify = true;
//     }

//     if (_screenHeight != height) {
//       _screenHeight = height;
//       shouldNotify = true;
//     }

//     if (_isSmallScreen != newIsSmallScreen) {
//       _isSmallScreen = newIsSmallScreen;
//       shouldNotify = true;
//     }

//     if (shouldNotify) {
//       notifyListeners();
//     }
//   }
// }

//created by: FAMZY CodeWorks

import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 700;
  }

  static bool isTablet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return width >= 700 && width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }
}
