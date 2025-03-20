import 'package:flutter/material.dart';
import 'catalog.dart';

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => List.unmodifiable(_items);

  int get totalPrice => _items.length * 42;

  set catalog(CatalogModel catalog) {}

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
  
  void remove(Item item) {
    _items.remove(item);
    notifyListeners();
  }
}