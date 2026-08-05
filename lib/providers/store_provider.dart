
/*
import 'package:flutter/material.dart';
import 'package:movegui/models/store/store_model.dart';

class StoreProvider extends ChangeNotifier {
  StoreModel? _store;

  StoreModel? get store => _store;

  void setStore(StoreModel store) {
    _store = store;
    notifyListeners();
  }

  bool isOpen() {
    if (_store == null) return false;
    final now = DateTime.now();
    final openTime = DateTime(
      now.year,
      now.month,
      now.day,
      _store!.weeklyHours[now.weekday - 1].openTime!.hour,
      _store!.weeklyHours[now.weekday - 1].openTime!.minute,
    );
    final closeTime = DateTime(
      now.year,
      now.month,
      now.day,
      _store!.weeklyHours[now.weekday - 1].closeTime!.hour,
      _store!.weeklyHours[now.weekday - 1].closeTime!.minute,
    );
    return now.isAfter(openTime) && now.isBefore(closeTime);
  }

    void clearStore() {
    _store = null;
    notifyListeners();
  }
}
*/

