
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:takeaplate/Response_Model/ForgotPasswordResponse.dart';
import '../NETWORKS/network.dart';
import '../Response_Model/DeleteAccountResponse.dart';
import '../Response_Model/EditProfileResponse.dart';
import '../Response_Model/LogInResponse.dart';
import '../Response_Model/RegisterResponse.dart';
import '../Response_Model/UploadImageResponse.dart';
import '../UTILS/request_string.dart';
import '../UTILS/utils.dart';

class AuthenticationProvider extends ChangeNotifier {
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

  Future<RegisterResponse> registerUser(dynamic formData) async {

    try {
      final response = await _network.postRequest(
        endPoint: '/register', // Replace with your actual API endpoint
        formData: formData,
      );

      print("Register response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return RegisterResponse.fromJson(responseData);
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


  Future<ForgotPasswordResponse> forgotPassword(dynamic formData) async {

    try {
      final response = await _network.postRequest(
        endPoint: '/forgot-password', // Replace with your actual API endpoint
        formData: formData,
      );

      print("my response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return ForgotPasswordResponse.fromJson(responseData);
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


  Future<DeleteAccountResponse> deleteAccount() async {

    var ID =  await Utility.getIntValue(RequestString.ID);
    print("user_Id: $ID");

    try {
      final response = await _network.deleteRequest(
        endPoint: '/delete-account/$ID', // Replace with your actual API endpoint
      );

      print("my response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return DeleteAccountResponse.fromJson(responseData);
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


  Future<UploadImageResponse> uploadMultipartImage(File file, String type) async {

    try {
      final response = await _network.uploadFile(file,type);

      print("my response : ${response}");

      if (response != null) {
         var responseData = response.data;

        return UploadImageResponse.fromJson(responseData);
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

  Future<EditProfileResponse> editProfile(dynamic formData) async {

    try {
      final response = await _network.postRequest(
        endPoint: '/edit-profile', // Replace with your actual API endpoint
        formData: formData,
      );

      print("EditProfile response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return EditProfileResponse.fromJson(responseData);
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
