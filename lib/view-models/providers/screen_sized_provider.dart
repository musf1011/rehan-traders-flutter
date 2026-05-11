// //created by: FAMZY CodeWorks

// import 'package:flutter/material.dart';

// class ScreenSizeProvider extends InheritedWidget {
//   final bool isSmallScreen;
//   final double screenWidth;
//   final double screenHeight;

//   const ScreenSizeProvider({
//     super.key,
//     required this.isSmallScreen,
//     required this.screenWidth,
//     required this.screenHeight,
//     required super.child,
//   });

//   static ScreenSizeProvider? of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<ScreenSizeProvider>();
//   }

//   @override
//   bool updateShouldNotify(ScreenSizeProvider oldWidget) {
//     return isSmallScreen != oldWidget.isSmallScreen ||
//         screenWidth != oldWidget.screenWidth ||
//         screenHeight != oldWidget.screenHeight;
//   }
// }

// // Wrapper widget to listen to screen changes
// class ScreenSizeWrapper extends StatefulWidget {
//   final Widget child;
//   const ScreenSizeWrapper({super.key, required this.child});

//   @override
//   State<ScreenSizeWrapper> createState() => _ScreenSizeWrapperState();
// }

// class _ScreenSizeWrapperState extends State<ScreenSizeWrapper> {
//   late bool isSmallScreen;
//   late double screenWidth;
//   late double screenHeight;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _updateScreenSize();
//   }

//   void _updateScreenSize() {
//     final size = MediaQuery.of(context).size;
//     screenWidth = size.width;
//     screenHeight = size.height;
//     isSmallScreen = screenWidth < 700;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // Update when layout changes
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           if (screenWidth != constraints.maxWidth) {
//             setState(() {
//               screenWidth = constraints.maxWidth;
//               screenHeight = constraints.maxHeight;
//               isSmallScreen = screenWidth < 700;
//             });
//           }
//         });

//         return ScreenSizeProvider(
//           isSmallScreen: isSmallScreen,
//           screenWidth: screenWidth,
//           screenHeight: screenHeight,
//           child: widget.child,
//         );
//       },
//     );
//   }
// }
