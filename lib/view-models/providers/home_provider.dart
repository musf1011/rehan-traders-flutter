// import 'package:flutter/material.dart';
// import 'package:rehan_trader_website/core/services/product_service.dart';
// import 'package:rehan_trader_website/models/product_model.dart';

// class HomeProvider extends ChangeNotifier {
//   final ProductService _service = ProductService();

//   List<ProductModel> allProducts = [];

//   bool isLoading = false;

//   Future<void> loadProducts() async {
//     isLoading = true;
//     notifyListeners();

//     _service.getProducts().listen((products) {
//       allProducts = products;

//       isLoading = false;

//       notifyListeners();
//     });
//   }

//   List<String> get categories {
//     final data = allProducts.map((e) => e.category).toSet().toList();

//     return data;
//   }

//   List<ProductModel> productsByCategory(String category) {
//     return allProducts.where((e) => e.category == category).toList();
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rehan_trader_website/core/services/product_service.dart';
import 'package:rehan_trader_website/models/product_model.dart';

class HomeProvider extends ChangeNotifier {
  final ProductService _service = ProductService();

  List<ProductModel> _allProducts = [];

  List<ProductModel> get allProducts => _allProducts;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  StreamSubscription<List<ProductModel>>? _productsSubscription;

  // SEARCH
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  // LOCAL CATEGORY LIST
  final List<String> categories = [
    'Furniture',
    'Footwear',
    'Safety Gear',
    'Bags',
    'tactical',
    'hiking',
    'camping',
    'safety',
  ];

  // INIT
  void initProducts() {
    if (_productsSubscription != null) return;

    _isLoading = true;
    notifyListeners();

    _productsSubscription = _service.getProducts().listen((products) {
      _allProducts = products;

      _isLoading = false;

      notifyListeners();
    });
  }

  // SEARCH
  void updateSearch(String value) {
    _searchQuery = value.toLowerCase();

    notifyListeners();
  }

  // FILTERED PRODUCTS
  List<ProductModel> get filteredProducts {
    if (_searchQuery.isEmpty) {
      return _allProducts;
    }

    return _allProducts.where((product) {
      return product.name.toLowerCase().contains(_searchQuery) ||
          product.description.toLowerCase().contains(_searchQuery) ||
          product.category.toLowerCase().contains(_searchQuery);
    }).toList();
  }

  // PRODUCTS BY CATEGORY
  List<ProductModel> productsByCategory(String category) {
    return filteredProducts.where((e) => e.category == category).toList();
  }

  @override
  void dispose() {
    _productsSubscription?.cancel();

    super.dispose();
  }
}
