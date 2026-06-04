import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class MainProvider extends ChangeNotifier {
  // // Initialize SidebarXController
  // final SidebarXController sideBarController = SidebarXController(
  //   selectedIndex: 0,
  //   extended: true,
  // );

  //  void onSidebarItemTapped(int index) {
  //   sideBarController.selectIndex(index);

  //   // Update the selectedItems list for the custom underline effect
  //   for (int i = 0; i < selectedItems.length; i++) {
  //     selectedItems[i] = (i == index);
  //   }
  //   // close the drawer when an item is tapped

  //   notifyListeners();
  // }

  final SidebarXController sideBarController = SidebarXController(
    selectedIndex: 0,
    extended: true,
  );

  int selectedIndex = 0;

  void onSidebarItemTapped(int index) {
    selectedIndex = index;

    sideBarController.selectIndex(index);

    notifyListeners();
  }

  // Manage the selected underline state
  // List<bool> selectedItems = List.generate(7, (index) => false);

  // List<String> categories = [];

  // MainProvider() {
  //   // Set initial state
  //   // selectedItems[0] = true;
  // }

  // void setCategories(List<String> newCategories) {
  //   categories = newCategories;
  //   notifyListeners();
  // }

  // Helper to get title easily in the UI
  // String get currentTitle => getTitleByIndex(sideBarController.selectedIndex);

  // static String getTitleByIndex(int index) {
  //   switch (index) {
  //     case 0:
  //       return 'HOME';
  //     case 1:
  //       return 'Hiking';
  //     case 2:
  //       return 'Safety';
  //     case 3:
  //       return 'FootWears';
  //     case 4:
  //       return 'Bags';
  //     case 5:
  //       return 'Add Product';
  //     default:
  //       return 'Not found page';
  //   }
  // }
}
