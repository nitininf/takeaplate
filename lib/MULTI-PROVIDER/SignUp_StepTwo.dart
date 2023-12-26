import 'package:flutter/material.dart';

class SignUp_StepTwo with ChangeNotifier {

  String fullName = '';
  String email = '';
  String phoneNumber = '';
  String dob = '';
  String gender = '';
  String user_image = '';


  void saveSignUpStepTwoData({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String dob,
    required String gender,
    required String user_image,

  }) {
    this.fullName = fullName;
    this.email = email;
    this.phoneNumber = phoneNumber;
    this.dob = dob;
    this.gender = gender;
    this.user_image = user_image;

    notifyListeners();
  }
}
