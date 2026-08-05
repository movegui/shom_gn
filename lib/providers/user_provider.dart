import 'package:flutter/material.dart';
import 'package:shom_gn/models/user_model.dart';


class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  bool isLoggedIn() {
    return _user != null;
  }
}

