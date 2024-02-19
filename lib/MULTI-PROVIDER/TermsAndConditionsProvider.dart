
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:take_a_plate/Response_Model/ForgotPasswordResponse.dart';
import 'package:take_a_plate/Response_Model/PrivacyPolicyResponse.dart';
import 'package:take_a_plate/Response_Model/TermsAndConditionsResponse.dart';
import '../NETWORKS/network.dart';
import '../Response_Model/DeleteAccountResponse.dart';
import '../Response_Model/EditProfileResponse.dart';
import '../Response_Model/LogInResponse.dart';
import '../Response_Model/RegisterResponse.dart';
import '../Response_Model/UploadImageResponse.dart';
import '../UTILS/request_string.dart';
import '../UTILS/utils.dart';

class TermsAndConditionsProvider extends ChangeNotifier {
  final Network _network = Network();

  Future<TermsAndConditionsResponse> getPrivacyPolicyData() async {

    try {
      final response = await _network.getRequest(
        endPoint: '/condition-list', // Replace with your actual API endpoint
      );

      print("my response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return TermsAndConditionsResponse.fromJson(responseData);
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
