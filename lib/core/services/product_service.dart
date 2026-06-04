// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rehan_trader_website/models/product_model.dart';

// class ProductService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   Future<void> saveProduct(ProductModel product, List<File> localImages) async {
//     List<String> uploadedUrls = [];

//     // Upload new images if provided
//     for (var image in localImages) {
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       Reference ref = _storage.ref().child('products/$fileName');
//       await ref.putFile(image);
//       uploadedUrls.add(await ref.getDownloadURL());
//     }

//     product.imageUrls = uploadedUrls;

//     if (product.id == null) {
//       await _db.collection('products').add(product.toMap());
//     } else {
//       await _db.collection('products').doc(product.id).update(product.toMap());
//     }
//   }
// }

// Future<void> saveProduct(ProductModel product, List<image> localImages) async {
//   try {
//     List<String> uploadedUrls = [];

//     for (var image in localImages) {
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();

//       Reference ref = _storage.ref().child('products/$fileName.jpg');

//       UploadTask uploadTask = ref.putFile(image);

//       TaskSnapshot snapshot = await uploadTask;

//       String downloadUrl = await snapshot.ref.getDownloadURL();

//       uploadedUrls.add(downloadUrl);
//     }

//     product.imageUrls = uploadedUrls;

//     if (product.id == null) {
//       await _db.collection('products').add(product.toMap());
//     } else {
//       await _db
//           .collection('products')
//           .doc(product.id)
//           .update(product.toMap());
//     }
//   } catch (e) {
//     rethrow;
//   }
// }

//created by: FAMZY CodeWorks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:rehan_trader_website/models/product_image_model.dart';
import 'package:rehan_trader_website/models/product_model.dart';

class ProductService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> saveProduct(
    ProductModel product,
    List<ProductImageModel> localImages,
  ) async {
    try {
      List<String> uploadedUrls = [];

      // for (var image in localImages) {
      //   String fileName =
      //       (product.name + DateTime.now().millisecondsSinceEpoch.toString())
      //           .replaceAll(' ', '_');

      //   Reference ref = _storage.ref().child('products/$fileName.jpg');

      //   UploadTask uploadTask = ref.putData(
      //     image.bytes,
      //     SettableMetadata(contentType: 'image/jpeg'),
      //   );

      //   TaskSnapshot snapshot = await uploadTask;

      //   String downloadUrl = await snapshot.ref.getDownloadURL();

      //   uploadedUrls.add(downloadUrl);
      // }

      for (var image in localImages) {
        String fileName =
            (product.name + DateTime.now().millisecondsSinceEpoch.toString())
                .replaceAll(' ', '_');

        String extension = image.name.split('.').last;

        Reference ref = _storage.ref().child('products/$fileName.$extension');

        final mimeType = lookupMimeType(image.name);

        UploadTask uploadTask = ref.putData(
          image.bytes,
          SettableMetadata(contentType: mimeType),
        );

        TaskSnapshot snapshot = await uploadTask;

        String downloadUrl = await snapshot.ref.getDownloadURL();

        uploadedUrls.add(downloadUrl);
      }

      debugPrint('*** uplaod urls: $uploadedUrls');
      product.imageUrls = uploadedUrls;

      // if (product.id == null) {
      //   await _db.collection('products').add(product.toMap());
      // } else {
      //   await _db
      //       .collection('products')
      //       .doc(product.id)
      //       .update(product.toMap());
      // }

      await _db
          .collection('products')
          .doc(product.id)
          .set(product.toMap(), SetOptions(merge: true));
    } catch (e) {
      rethrow;
    }
  }

  //get all products
  Stream<List<ProductModel>> getProducts() {
    return _db
        .collection('products')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return ProductModel.fromMap(doc.data(), doc.id);
          }).toList();
        });
  }

  //get products by category
  Stream<List<ProductModel>> getProductsByCategory(String category) {
    return _db
        .collection('products')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return ProductModel.fromMap(doc.data(), doc.id);
          }).toList();
        });
  }

  //search products
  Future<List<ProductModel>> searchProducts(String query) async {
    final result = await _db
        .collection('products')
        .where('searchKeywords', arrayContains: query.toLowerCase())
        .get();

    return result.docs.map((doc) {
      return ProductModel.fromMap(doc.data(), doc.id);
    }).toList();
  }
}
