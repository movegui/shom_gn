import 'package:flutter/widgets.dart';
import 'package:shom_gn/models/order_model.dart';

class ShoppingProvider with ChangeNotifier {
  int _itemCount = 0;
  final List<OrderModel> _orders = [];

  int get itemCount => _itemCount;
  List<OrderModel> get orders => _orders;


  void addItem(OrderModel order) {
    _itemCount++;
    _orders.add(order);
    notifyListeners();
  }

  void removeItem(int index) {
    if (_itemCount > 0) {
      _itemCount--;
      _orders.removeAt(index);
      notifyListeners();
    }
  }

  void clearCart() {
    _itemCount = 0;
    _orders.clear();
    notifyListeners();
  }
  int length(){
    return _orders.length;
  }
}
