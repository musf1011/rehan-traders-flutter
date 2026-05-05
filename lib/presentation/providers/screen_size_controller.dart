//created by: FAMZY CodeWorks

import 'package:flutter/material.dart';

class ScreenSizeController extends ChangeNotifier {
  bool _isSmallScreen = false;
  double _screenWidth = 0;
  double _screenHeight = 0;

  bool get isSmallScreen => _isSmallScreen;
  double get screenWidth => _screenWidth;
  double get screenHeight => _screenHeight;

  void updateScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final newIsSmallScreen = width < 700;

    if (_screenWidth != width || _isSmallScreen != newIsSmallScreen) {
      _screenWidth = width;
      _screenHeight = height;
      _isSmallScreen = newIsSmallScreen;
      notifyListeners();
    }
  }
}
