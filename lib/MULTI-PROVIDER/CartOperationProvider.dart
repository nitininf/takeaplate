import 'package:flutter/material.dart';

class CartOperationProvider extends ChangeNotifier {
  Map<int, int> itemCounts = {}; // Map to store item indices and their counts

  void incrementCount(int index) {
    if (!itemCounts.containsKey(index)) {
      itemCounts[index] = 1;
    } else {
      itemCounts[index] = itemCounts[index]! + 1;
    }
    notifyListeners();
  }

  void decrementCount(int index) {
    if (itemCounts.containsKey(index) && itemCounts[index]! > 1) {
      itemCounts[index] = itemCounts[index]! - 1;
      notifyListeners();
    }
  }

  int getCount(int index) {
    return itemCounts.containsKey(index) ? itemCounts[index]! : 0;
  }

  void removeFromCart(int index) {
    itemCounts[index] = 1;
    notifyListeners();
  }


}
