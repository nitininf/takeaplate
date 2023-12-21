import 'dart:convert';
import 'package:flutter/material.dart';
import '../NETWORKS/network.dart';
import '../Response_Model/LogInResponse.dart';

class LoginProvider extends ChangeNotifier {
  final Network _network = Network();

  Future<LoginResponse> loginUser(dynamic formData) async {

    try {
      final response = await _network.postRequest(
        endPoint: '/login', // Replace with your actual API endpoint
        formData: formData,
      );

      print("my response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return LoginResponse.fromJson(responseData);
      } else {
        throw Exception('Failed to parse API response');
      }
    } catch (error) {
      // Handle network errors or any other exceptions
      print('Error: $error');
      rethrow; // Re-throw the error to the caller
    } finally {
      notifyListeners();
    }
  }
}
