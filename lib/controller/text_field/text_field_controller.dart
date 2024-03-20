import 'package:flutter/material.dart';

class ShowTextFeildProvider extends ChangeNotifier {
  bool _isVisible = false;

  bool get isVisible => _isVisible;

  void toggleVisbility(bool value){
    _isVisible = value;
    notifyListeners();
  }
  
}