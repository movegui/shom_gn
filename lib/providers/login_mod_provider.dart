import 'package:flutter/material.dart';

class LoginModProvider with ChangeNotifier{
   int loginMode = -1;

   void setLoginMod(int logMog){
    loginMode = logMog;
    notifyListeners();
   }
}