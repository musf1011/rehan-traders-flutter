import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  String name;
  String description;
  String category;
  double originalPrice;
  double offerPercentage; // e.g., 10 for 10%
  double discountedPrice;
  List<String> imageUrls;
  DateTime? createdAt;

  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.originalPrice,
    this.offerPercentage = 0,
    required this.discountedPrice,
    required this.imageUrls,
    this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'description': description,
    'category': category,
    'originalPrice': originalPrice,
    'offerPercentage': offerPercentage,
    'discountedPrice': discountedPrice,
    'imageUrls': imageUrls,
    'createdAt': createdAt ?? FieldValue.serverTimestamp(),
  };

  factory ProductModel.fromMap(Map<String, dynamic> map, String id) =>
      ProductModel(
        id: id,
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        category: map['category'] ?? 'Uncategorized',
        originalPrice: (map['originalPrice'] ?? 0).toDouble(),
        offerPercentage: (map['offerPercentage'] ?? 0).toDouble(),
        discountedPrice: (map['discountedPrice'] ?? 0).toDouble(),
        imageUrls: List<String>.from(map['imageUrls'] ?? []),
      );
}
