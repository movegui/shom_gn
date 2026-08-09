
import 'package:flutter/material.dart';

class PreviousRouteProvider with ChangeNotifier {
  String _previousRoute = "";

  String get previousRoute => _previousRoute;

  void setPreviousRoute(String newRoute) {
    _previousRoute = newRoute;
    notifyListeners();
  }
}
