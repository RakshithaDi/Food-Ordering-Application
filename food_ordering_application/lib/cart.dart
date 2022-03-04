import 'package:flutter/cupertino.dart';

import 'item.dart';

class Cart extends ChangeNotifier {
  static List<Item> _items = [];

  static double _totalPrice = 0.0;
  void add(Item item) {
    _items.add(item);
    _totalPrice += item.price;
    notifyListeners();
  }

  static void remove(Item item) {
    _totalPrice -= item.price;
    _items.remove(item);
    // notifyListeners();
  }

  static int get count {
    return _items.length;
  }

  static double get totalPrice {
    return _totalPrice;
  }

  static List<Item> get basketItems {
    return _items;
  }
}
