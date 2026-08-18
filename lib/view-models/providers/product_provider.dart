// //created by: FAMZY CodeWorks

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:rehan_trader_website/core/services/product_service.dart';

// class ProductProvider extends ChangeNotifier {
//   final ProductService _productService = ProductService();

//   List<File> selectedImages = []; // Local files for upload
//   double originalPrice = 0;
//   double offer = 0;
//   double finalPrice = 0;
//   String category = '';
//   bool isLoading = false;

//   void addImage(File image) {
//     if (selectedImages.length < 3) {
//       selectedImages.add(image);
//       notifyListeners();
//     }
//   }

//   // Reorder images: The first image in the list is the "Cover"
//   void reorderImages(int oldIndex, int newIndex) {
//     if (newIndex > oldIndex) newIndex -= 1;
//     final item = selectedImages.removeAt(oldIndex);
//     selectedImages.insert(newIndex, item);
//     notifyListeners();
//   }

//   void calculateDiscount(String value, bool isOriginalPrice) {
//     if (isOriginalPrice) {
//       originalPrice = double.tryParse(value) ?? 0;
//     } else {
//       offer = double.tryParse(value) ?? 0;
//     }
//     finalPrice = originalPrice - (originalPrice * (offer / 100));
//     notifyListeners();
//   }
// }

//created by: FAMZY CodeWorks

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rehan_trader_website/core/utils/product_helper.dart';
import 'package:rehan_trader_website/models/product_image_model.dart';
import 'package:rehan_trader_website/models/product_model.dart';
import 'package:rehan_trader_website/core/services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();

  // final ImagePicker _picker = ImagePicker();

  // List<File> selectedImages = [];
  List<ProductImageModel> selectedImages = [];

  double originalPrice = 0;
  double offer = 0;
  double finalPrice = 0;

  String category = '';

  bool isLoading = false;

  String? _imageValidationError;

  String? get imageValidationError => _imageValidationError;
  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController offerController = TextEditingController();

  Future<void> pickImages() async {
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        allowMultiple: true,
        type: FileType.image,
        withData: true,
        compressionQuality: 30,
      );

      if (result != null) {
        for (var file in result.files) {
          if (selectedImages.length < 3) {
            if (file.bytes != null) {
              selectedImages.add(
                ProductImageModel(bytes: file.bytes!, name: file.name),
              );
            }
          }
        }

        notifyListeners();
      }
    } catch (e) {
      debugPrint('Image Picker Error: $e');
    }
  }

  // REMOVE IMAGE
  void removeImage(int index) {
    selectedImages.removeAt(index);
    notifyListeners();
  }

  // REORDER IMAGES
  void reorderImages(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = selectedImages.removeAt(oldIndex);

    selectedImages.insert(newIndex, item);

    notifyListeners();
  }

  // Add validation method
  bool validateImages() {
    if (selectedImages.isEmpty) {
      _imageValidationError = '*At least one product image is required';
      notifyListeners();
      return false;
    }

    _imageValidationError = null;
    notifyListeners();
    return true;
  }

  // CALCULATE DISCOUNT
  void calculateDiscount(String value, bool isOriginalPrice) {
    final oldPrice = finalPrice;

    if (isOriginalPrice) {
      originalPrice = double.tryParse(value) ?? 0;
    } else {
      offer = double.tryParse(value) ?? 0;
    }

    finalPrice = originalPrice - (originalPrice * (offer / 100));

    if (oldPrice != finalPrice) {
      notifyListeners();
    }
  }

  // SAVE PRODUCT
  Future<bool> uploadProduct() async {
    try {
      isLoading = true;
      notifyListeners();

      // ProductModel product = ProductModel(

      //   name: nameController.text.trim(),
      //   description: descriptionController.text.trim(),
      //   category: category,
      //   originalPrice: originalPrice,
      //   offerPercentage: offer,
      //   discountedPrice: finalPrice,
      //   imageUrls: [],
      // );

      final productId = ProductHelper.generateProductId(
        nameController.text.trim(),
      );

      ProductModel product = ProductModel(
        id: productId,
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        category: category,
        originalPrice: originalPrice,
        offerPercentage: offer,
        discountedPrice: finalPrice,
        imageUrls: [],
        searchKeywords: ProductHelper.generateSearchKeywords(
          nameController.text.trim(),
        ),
      );

      await _productService.saveProduct(product, selectedImages);

      clearFields();

      isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      debugPrint("UPLOAD ERROR: $e");

      isLoading = false;
      notifyListeners();

      return false;
    }
  }

  // CLEAR
  void clearFields() {
    selectedImages.clear();

    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    offerController.clear();

    originalPrice = 0;
    offer = 0;
    finalPrice = 0;

    category = '';

    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    offerController.dispose();

    super.dispose();
  }
}
