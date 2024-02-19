
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:take_a_plate/Response_Model/ContactUsResponse.dart';
import 'package:take_a_plate/Response_Model/ForgotPasswordResponse.dart';
import '../NETWORKS/network.dart';
import '../Response_Model/DeleteAccountResponse.dart';
import '../Response_Model/EditProfileResponse.dart';
import '../Response_Model/LogInResponse.dart';
import '../Response_Model/RegisterResponse.dart';
import '../Response_Model/UploadImageResponse.dart';
import '../UTILS/request_string.dart';
import '../UTILS/utils.dart';

class ContactUsProvider extends ChangeNotifier {
  final Network _network = Network();

  Future<ContactUsResponse> contactUsForm(dynamic formData) async {

    try {
      final response = await _network.postRequest(
        endPoint: '/contact-us', // Replace with your actual API endpoint
        formData: formData,
      );

      print("my response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return ContactUsResponse.fromJson(responseData);
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
