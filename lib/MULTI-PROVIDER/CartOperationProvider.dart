import 'package:flutter/material.dart';

import '../NETWORKS/network.dart';
import '../Response_Model/AddToCartResponse.dart';
import '../Response_Model/CartListingResponse.dart';
import '../UTILS/request_string.dart';

class CartOperationProvider extends ChangeNotifier {
  final Network _network = Network();

  Map<int, int> itemCounts = {}; // Map to store item indices and their counts

  void incrementCount(int index) {
    if (!itemCounts.containsKey(index)) {
      itemCounts[index] = 1;
    } else {
      itemCounts[index] = itemCounts[index]! + 1;
    }
    notifyListeners();
  }

  void decrementCount(int index) {
    if (itemCounts.containsKey(index) && itemCounts[index]! > 1) {
      itemCounts[index] = itemCounts[index]! - 1;
      notifyListeners();
    }
  }

  int getCount(int index) {
    return itemCounts.containsKey(index) ? itemCounts[index]! : 0;
  }

  void removeFromCart(int index) {
    itemCounts[index] = 1;
    notifyListeners();
  }

  Future<AddToCartResponse> addToCartItem(dynamic formData) async {

    try {
      final response = await _network.postRequest(
        endPoint: '/add-cart', // Replace with your actual API endpoint
        formData: formData,
      );


      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return AddToCartResponse.fromJson(responseData);
      } else {
        throw Exception('Failed to parse API response');
      }
    } catch (error) {
      // Handle network errors or any other exceptions
      rethrow; // Re-throw the error to the caller
    } finally {
      notifyListeners();
    }
  }


  Future<CartListingResponse> getCartList() async {
    // Make network request with pagination parameters
    // You might need to update your API endpoint to support pagination
    final response = await _network.getRequest(
      endPoint: '/cart-list',
    );

    if (response != null && response.data is Map<String, dynamic>) {
      final Map<String, dynamic> responseData = response.data;
      return CartListingResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to parse API response');
    }
  }

  Future<AddToCartResponse> increaseItemQuantity(var cartId) async {


    var formData = {
      RequestString.QUANTITY: 1,

    };

    // Make network request with pagination parameters
    // You might need to update your API endpoint to support pagination
    final response = await _network.postRequest(
      endPoint: '/cart-quantity-increment/$cartId',
      formData: formData
    );

    if (response != null && response.data is Map<String, dynamic>) {
      final Map<String, dynamic> responseData = response.data;
      return AddToCartResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to parse API response');
    }
  }


  Future<AddToCartResponse> decreaseItemQuantity(var cartId) async {


    var formData = {
      RequestString.QUANTITY: 1,

    };

    // Make network request with pagination parameters
    // You might need to update your API endpoint to support pagination
    final response = await _network.postRequest(
      endPoint: '/cart-quantity-decrement/$cartId',
      formData: formData
    );

    if (response != null && response.data is Map<String, dynamic>) {
      final Map<String, dynamic> responseData = response.data;
      return AddToCartResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to parse API response');
    }
  }



}
