import 'package:flutter/cupertino.dart';

class ItemModel with ChangeNotifier {
  List items = [];

  int get itemLength => items.length;

  void addItem(String item) {
    items.add(item);
    notifyListeners();
  }

  void deleteItem(int index) {
    items.removeAt(index);
    notifyListeners();
  }
}