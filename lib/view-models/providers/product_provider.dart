import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rehan_trader_website/core/services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _service = ProductService();

  List<File> selectedImages = []; // Local files for upload
  double originalPrice = 0;
  double offer = 0;
  double finalPrice = 0;
  String category = '';
  bool isLoading = false;

  void addImage(File image) {
    if (selectedImages.length < 3) {
      selectedImages.add(image);
      notifyListeners();
    }
  }

  // Reorder images: The first image in the list is the "Cover"
  void reorderImages(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = selectedImages.removeAt(oldIndex);
    selectedImages.insert(newIndex, item);
    notifyListeners();
  }

  void calculateDiscount(String value, bool isOriginalPrice) {
    if (isOriginalPrice) {
      originalPrice = double.tryParse(value) ?? 0;
    } else {
      offer = double.tryParse(value) ?? 0;
    }
    finalPrice = originalPrice - (originalPrice * (offer / 100));
    notifyListeners();
  }
}
