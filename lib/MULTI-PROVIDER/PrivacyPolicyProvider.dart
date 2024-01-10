
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:takeaplate/Response_Model/ForgotPasswordResponse.dart';
import 'package:takeaplate/Response_Model/PrivacyPolicyResponse.dart';
import '../NETWORKS/network.dart';
import '../Response_Model/DeleteAccountResponse.dart';
import '../Response_Model/EditProfileResponse.dart';
import '../Response_Model/LogInResponse.dart';
import '../Response_Model/RegisterResponse.dart';
import '../Response_Model/UploadImageResponse.dart';
import '../UTILS/request_string.dart';
import '../UTILS/utils.dart';

class PrivacyPolicyProvider extends ChangeNotifier {
  final Network _network = Network();

  Future<PrivacyPolicyResponse> getPrivacyPolicyData() async {

    try {
      final response = await _network.getRequest(
        endPoint: '/policy-list', // Replace with your actual API endpoint
      );

      print("my response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return PrivacyPolicyResponse.fromJson(responseData);
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
