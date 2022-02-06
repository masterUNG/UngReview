// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String urlImage;
  final String nameProduct;
  final String detailProduct;
  final String uidSeller;
  final Timestamp timestamp;
  ProductModel({
    required this.urlImage,
    required this.nameProduct,
    required this.detailProduct,
    required this.uidSeller,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'urlImage': urlImage,
      'nameProduct': nameProduct,
      'detailProduct': detailProduct,
      'uidSeller': uidSeller,
      'timestamp': timestamp,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      urlImage: (map['urlImage'] ?? '') as String,
      nameProduct: (map['nameProduct'] ?? '') as String,
      detailProduct: (map['detailProduct'] ?? '') as String,
      uidSeller: (map['uidSeller'] ?? '') as String,
      timestamp: (map['timestamp']),
    );
  }

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
