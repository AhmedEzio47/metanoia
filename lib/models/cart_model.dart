import 'package:flutter/foundation.dart';
import 'package:metanoia/models/product_model.dart';

class CartModel extends ChangeNotifier {
  Map<Product, int> get items => _items;

  /// The current total price of all items (assuming all items cost $42).
  int get totalPrice => _totalPrice;
  Map<Product, int> _items = Map();

  int _totalPrice = 0;

  void add(Product item) {
    _totalPrice += item.price;
    if (_items.containsKey(item)) {
      _items[item]++;
    } else {
      _items.putIfAbsent(item, () => 1);
    }
    notifyListeners();
  }

  void clear() {
    _totalPrice = 0;
    _items.clear();
    notifyListeners();
  }
}
