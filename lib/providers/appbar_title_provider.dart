import 'package:flutter/material.dart';

class AppbarTitleProvider with ChangeNotifier {
  String _title = "";

  String get title => _title;

  void setTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }
}
