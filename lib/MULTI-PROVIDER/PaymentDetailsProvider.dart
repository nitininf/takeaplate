import 'package:flutter/material.dart';
import 'package:take_a_plate/Response_Model/CardDeleteResponse.dart';

import '../NETWORKS/network.dart';
import '../Response_Model/AddPaymentCardResponse.dart';
import '../Response_Model/CardListResponse.dart';


class PaymentDetailsProvider extends ChangeNotifier {

  final Network _network = Network();

  Future<AddPaymentCardResponse> addPaymentCard(dynamic formData) async {

    try {
      final response = await _network.postRequest(
        endPoint: '/add-payment-card', // Replace with your actual API endpoint
        formData: formData,
      );

      print("my response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return AddPaymentCardResponse.fromJson(responseData);
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


  Future<CardListResponse> getCardList() async {
    // Make network request with pagination parameters
    // You might need to update your API endpoint to support pagination
    final response = await _network.getRequest(
      endPoint: '/get-card',
    );

    if (response != null && response.data is Map<String, dynamic>) {
      final Map<String, dynamic> responseData = response.data;
      return CardListResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to parse API response');
    }
  }


  Future<CardDeleteResponse> deletePaymentCard(int selectedCardIndex) async {



    try {
      final response = await _network.deleteRequest(
        endPoint: '/delete-payment-card/$selectedCardIndex', // Replace with your actual API endpoint
      );

      print("my response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return CardDeleteResponse.fromJson(responseData);
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
