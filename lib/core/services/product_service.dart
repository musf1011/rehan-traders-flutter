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

//created by: FAMZY CodeWorks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:rehan_trader_website/models/product_image_model.dart';
import 'package:rehan_trader_website/models/product_model.dart';

class ProductService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

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
  Future<void> saveProduct(
    ProductModel product,
    List<ProductImageModel> localImages,
  ) async {
    try {
      List<String> uploadedUrls = [];

      for (var image in localImages) {
        String fileName =
            (product.name + DateTime.now().millisecondsSinceEpoch.toString())
                .replaceAll(' ', '_');

        Reference ref = _storage.ref().child('products/$fileName.jpg');

        UploadTask uploadTask = ref.putData(
          image.bytes,
          SettableMetadata(contentType: 'image/jpeg'),
        );

        TaskSnapshot snapshot = await uploadTask;

        String downloadUrl = await snapshot.ref.getDownloadURL();

        uploadedUrls.add(downloadUrl);
      }
      debugPrint('*** uplaod urls: $uploadedUrls');
      product.imageUrls = uploadedUrls;

      if (product.id == null) {
        await _db.collection('products').add(product.toMap());
      } else {
        await _db
            .collection('products')
            .doc(product.id)
            .update(product.toMap());
      }
    } catch (e) {
      rethrow;
    }
  }
}
