import 'package:flutter/material.dart';

class TextfieldValidatorProvider extends ChangeNotifier {
  String? _email;
  String? _password;
  String? _otp;

  String? get email => _email;
  String? get password => _password;
  String? get otp => _otp;

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6 && value.isNotEmpty) {
      return 'Minimum 6 characters requiered';
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your Email';
    } else if (value.isEmpty ||
        !RegExp(r'^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$')
            .hasMatch(value)) {
      return 'Enter valid Email';
    } else {
      return null;
    }
  }

  String? validateOTP(String? value) {
    if (value!.isEmpty) {
      return 'please enter OTP';
    } else {
      return null;
    }
  }

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  void updateOTP(String value){
    _otp = value;
    notifyListeners();
  }
}