import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class MainProvider extends ChangeNotifier {
  // Initialize SidebarXController
  final SidebarXController sideBarController = SidebarXController(
    selectedIndex: 0,
    extended: true,
  );

  // Manage the selected underline state
  List<bool> selectedItems = List.generate(7, (index) => false);

  MainProvider() {
    // Set initial state
    selectedItems[0] = true;
  }

  void onSidebarItemTapped(int index) {
    sideBarController.selectIndex(index);

    // Update the selectedItems list for the custom underline effect
    for (int i = 0; i < selectedItems.length; i++) {
      selectedItems[i] = (i == index);
    }
    // close the drawer when an item is tapped

    notifyListeners();
  }

  // Helper to get title easily in the UI
  String get currentTitle => getTitleByIndex(sideBarController.selectedIndex);

  static String getTitleByIndex(int index) {
    switch (index) {
      case 0:
        return 'HOME';
      case 1:
        return 'Sales Register';
      case 2:
        return 'Sales Report';
      case 3:
        return 'Products';
      case 4:
        return 'Payments';
      case 5:
        return 'Employees';
      default:
        return 'Not found page';
    }
  }
}
