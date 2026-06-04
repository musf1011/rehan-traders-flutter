// import 'package:cloud_firestore/cloud_firestore.dart';

// class ProductModel {
//   String? id;
//   String name;
//   String description;
//   String category;
//   double originalPrice;
//   double offerPercentage;
//   double discountedPrice;
//   List<String> imageUrls;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   ProductModel({
//     this.id,
//     required this.name,
//     required this.description,
//     required this.category,
//     required this.originalPrice,
//     this.offerPercentage = 0,
//     required this.discountedPrice,
//     required this.imageUrls,
//     this.createdAt,
//     this.updatedAt,
//   });

//   Map<String, dynamic> toMap() => {
//     'name': name,
//     'description': description,
//     'category': category,
//     'originalPrice': originalPrice,
//     'offerPercentage': offerPercentage,
//     'discountedPrice': discountedPrice,
//     'imageUrls': imageUrls,
//     'createdAt': createdAt ?? FieldValue.serverTimestamp(),
//     'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
//   };

//   factory ProductModel.fromMap(Map<String, dynamic> map, String id) =>
//       ProductModel(
//         id: id,
//         name: map['name'] ?? '',
//         description: map['description'] ?? '',
//         category: map['category'] ?? 'Uncategorized',
//         originalPrice: (map['originalPrice'] ?? 0).toDouble(),
//         offerPercentage: (map['offerPercentage'] ?? 0).toDouble(),
//         discountedPrice: (map['discountedPrice'] ?? 0).toDouble(),
//         imageUrls: List<String>.from(map['imageUrls'] ?? []),
//       );
// }

//created by: FAMZY CodeWorks

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  String name;
  String description;
  String category;

  double originalPrice;
  double offerPercentage;
  double discountedPrice;

  List<String> imageUrls;
  List<String> searchKeywords;

  DateTime? createdAt;
  DateTime? updatedAt;

  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.originalPrice,
    required this.offerPercentage,
    required this.discountedPrice,
    required this.imageUrls,
    required this.searchKeywords,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'originalPrice': originalPrice,
      'offerPercentage': offerPercentage,
      'discountedPrice': discountedPrice,
      'imageUrls': imageUrls,
      'searchKeywords': searchKeywords,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map, String docId) {
    return ProductModel(
      id: map['id'] ?? docId,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      originalPrice: (map['originalPrice'] ?? 0).toDouble(),
      offerPercentage: (map['offerPercentage'] ?? 0).toDouble(),
      discountedPrice: (map['discountedPrice'] ?? 0).toDouble(),
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      searchKeywords: List<String>.from(map['searchKeywords'] ?? []),

      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,

      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }
}
