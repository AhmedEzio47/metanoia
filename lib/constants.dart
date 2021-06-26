import 'package:cloud_firestore/cloud_firestore.dart';

///Images
const String defaultProductImage = 'assets/product_default.jpg';

///Database constants
final firestore = FirebaseFirestore.instance;
final productsRef = firestore.collection('products');

///Fonts
const String appFontFamily = 'SF UI Text';
