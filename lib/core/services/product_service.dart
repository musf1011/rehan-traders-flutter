import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rehan_trader_website/models/product_model.dart';

class ProductService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> saveProduct(ProductModel product, List<File> localImages) async {
    List<String> uploadedUrls = [];

    // Upload new images if provided
    for (var image in localImages) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('products/$fileName');
      await ref.putFile(image);
      uploadedUrls.add(await ref.getDownloadURL());
    }

    product.imageUrls = uploadedUrls;

    if (product.id == null) {
      await _db.collection('products').add(product.toMap());
    } else {
      await _db.collection('products').doc(product.id).update(product.toMap());
    }
  }
}
