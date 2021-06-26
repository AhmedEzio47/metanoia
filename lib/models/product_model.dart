import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class Product {
  final String id;
  final String name;
  final String image;
  final int price;
  final Timestamp timestamp;

  Product({this.id, this.name, this.image, this.price, this.timestamp});

  factory Product.fromDoc(var doc) {
    return Product(
        id: doc.id,
        name: doc['name'],
        image: doc['image'],
        price: int.parse(doc['price']),
        timestamp: doc['timestamp']);
  }

  static Future<List<Product>> getProducts() async {
    QuerySnapshot productsSnapshot =
        await productsRef.orderBy('timestamp', descending: true).get();
    List<Product> products =
        productsSnapshot.docs.map((doc) => Product.fromDoc(doc)).toList();
    return products;
  }
}
