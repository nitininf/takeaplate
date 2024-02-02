
import 'dart:io';

import 'package:flutter/material.dart';
import '../NETWORKS/network.dart';
import '../Response_Model/GetNotificationPrefResponse.dart';
import '../Response_Model/SendNotificationPrefResponse.dart';

class NotificationProvider extends ChangeNotifier {
  final Network _network = Network();

  Future<SendNotificationPrefResponse> sendNotificationPref(dynamic formData) async {

    try {
      final response = await _network.postRequest(
        endPoint: '/update-user-notification', // Replace with your actual API endpoint
        formData: formData,
      );

      print("my response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return SendNotificationPrefResponse.fromJson(responseData);
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


  Future<GetNotificationPrefResponse> getNotificationPref() async {

    try {
      final response = await _network.getRequest(
        endPoint: '/get-user-notification', // Replace with your actual API endpoint

      );

      print("Notification Preference response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;





        return GetNotificationPrefResponse.fromJson(responseData);
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
