import 'package:flutter/material.dart';

class SignUp_StepOne with ChangeNotifier {

  String fullName = '';
  String email = '';
  String phoneNumber = '';
  String dob = '';
  String gender = '';

  void saveSignUpStepOneData({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String dob,
    required String gender,
  }) {
    this.fullName = fullName;
    this.email = email;
    this.phoneNumber = phoneNumber;
    this.dob = dob;
    this.gender = gender;

    // Notify listeners to rebuild widgets that depend on this provider
    notifyListeners();
  }
}
