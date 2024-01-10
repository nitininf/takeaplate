import 'dart:async';

//import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Created by Nitin android

class Utility {
  static SharedPreferences? prefs;

  static getSharedPreferences() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  static setStringValue(String key, String value) async {
    // prefs = await SharedPreferences.getInstance();
    await getSharedPreferences();
    prefs?.setString(key, value);
  }

  static clearAll() async {
    //prefs = await SharedPreferences.getInstance();
    await getSharedPreferences();
    prefs?.clear();
  }

  static setIntValue(String key, int value) async {
    await getSharedPreferences();

    prefs?.setInt(key, value);
  }

  saveDoubleValue(String key, double value) async {
    prefs = await SharedPreferences.getInstance();
    prefs?.setDouble(key, value);
  }

  saveBoolValue(String key, bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs?.setBool(key, value);
  }

  saveStringListValue(String key, List<String> value) async {
    prefs = await SharedPreferences.getInstance();
    prefs?.setStringList(key, value);
  }

  static Future<String?> getStringValue(String value) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    await getSharedPreferences();
    return prefs?.getString(value);
  }

  static Future<int?> getIntValue(String value) async {
    prefs = await SharedPreferences.getInstance();
    return prefs?.getInt(value);
  }

  Future<double?> getDoubleValue(String value) async {
    prefs = await SharedPreferences.getInstance();
    return prefs?.getDouble(value);
  }

  Future<bool?> getBoolValue(String value) async {
    prefs = await SharedPreferences.getInstance();
    return prefs?.getBool(value);
  }

  Future<List<String>?> getListValue(String value) async {
    prefs = await SharedPreferences.getInstance();
    return prefs?.getStringList(value);
  }

  // static Future<bool> checkConnection() async {
  //   ConnectivityResult connectivityResult =
  //       await (Connectivity().checkConnectivity());
  //   if ((connectivityResult == ConnectivityResult.mobile) ||
  //       (connectivityResult == ConnectivityResult.wifi)) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }


  static bool containsUpperCase(String value) {
    return RegExp(r'[A-Z]').hasMatch(value);
  }

  static bool containsLowerCase(String value) {
    return RegExp(r'[a-z]').hasMatch(value);
  }

  static bool containsDigit(String value) {
    return RegExp(r'[0-9]').hasMatch(value);
  }

  static bool containsSpecialChar(String value) {
    return RegExp(r'[!@#\$&*~]').hasMatch(value);
  }

  static bool isStrongPassword(String value) {
    return containsUpperCase(value) &&
        containsLowerCase(value) &&
        containsDigit(value) &&
        containsSpecialChar(value) &&
        value.length >= 8;
  }

  static String getPasswordCriteriaMessage(String value) {
    String message = '';

    if (containsUpperCase(value)) {
      message += 'Contains uppercase letter. ';
    } else {
      message += 'Missing uppercase letter. ';
    }

    if (containsLowerCase(value)) {
      message += 'Contains lowercase letter. ';
    } else {
      message += 'Missing lowercase letter. ';
    }

    if (containsDigit(value)) {
      message += 'Contains digit. ';
    } else {
      message += 'Missing digit. ';
    }

    if (containsSpecialChar(value)) {
      message += 'Contains special character. ';
    } else {
      message += 'Missing special character. ';
    }

    if (value.length >= 8) {
      message += 'Password length is sufficient.';
    } else {
      message += 'Password should be at least 8 characters.';
    }

    return message.trim();
  }

  static void showAlert(BuildContext context, String text, String des) {
    Widget continueButton = TextButton(
      child: const Text("Got it"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        text,
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
      content: Text(des),
      actions: [
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
