
import 'package:flutter/material.dart';
import 'package:shom_gn/models/address_model.dart';


class AddressProvider extends ChangeNotifier {
  AddressModel? _address;

  AddressModel? get address => _address;

  void setAddress(AddressModel address) {
    _address = address;
    notifyListeners();
  }

  void clearAdress() {
    _address = null;
    notifyListeners();
  }

}