import 'package:flutter/cupertino.dart';
import 'package:takeaplate/Response_Model/RestaurantDealResponse.dart';

import '../NETWORKS/network.dart';

import '../Response_Model/RestaurantsListResponse.dart';

class RestaurantsListProvider extends ChangeNotifier {
  final Network _network = Network();


  Future<RestaurantsListResponse> getRestaurantsList({int page = 1}) async {
    // Make network request with pagination parameters
    // You might need to update your API endpoint to support pagination
    final response = await _network.getRequest(
      endPoint: '/store-list/$page',
    );

    if (response != null && response.data is Map<String, dynamic>) {
      final Map<String, dynamic> responseData = response.data;
      return RestaurantsListResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to parse API response');
    }
  }

  Future<RestaurantsListResponse> getClosestRestaurantsList({int page = 1}) async {

    try {
      final response = await _network.getRequest(
        endPoint: '/closed-resturent/$page', // Replace with your actual API endpoint

      );

      print("Restaurants response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return RestaurantsListResponse.fromJson(responseData);
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

  Future<RestaurentDealResponse> getRestaurantsDealsList(int? restaurantId,{int page = 1}) async {

    try {
      final response = await _network.getRequest(
        endPoint: '/get-deal/${restaurantId}/$page', // Replace with your actual API endpoint

      );

      print("Restaurant's Deal response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return RestaurentDealResponse.fromJson(responseData);
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

  Future<RestaurentDealResponse> getLastMinuteDealsList({int page = 1}) async {

    try {
      final response = await _network.getRequest(
        endPoint: '/last-minute-deal/$page', // Replace with your actual API endpoint

      );

      print("Restaurant's Deal response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return RestaurentDealResponse.fromJson(responseData);
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
