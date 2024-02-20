import 'package:flutter/cupertino.dart';
import 'package:take_a_plate/Response_Model/RestaurantDealResponse.dart';

import '../NETWORKS/network.dart';

import '../Response_Model/HomeItemsListingResponse.dart';
import '../Response_Model/RestaurantsListResponse.dart';

class RestaurantsListProvider extends ChangeNotifier {
  final Network _network = Network();

  Future<RestaurantsListResponse> getRestaurantsList(
      int filterId, dynamic formData,
      {int page = 1}) async {
    // Make network request with pagination parameters
    // You might need to update your API endpoint to support pagination
    final response = await _network.postRequest(
        endPoint: '/store-list/$filterId/$page', formData: formData);

    if (response != null && response.data is Map<String, dynamic>) {
      final Map<String, dynamic> responseData = response.data;
      return RestaurantsListResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to parse API response');
    }
  }

  Future<RestaurantsListResponse> getFavRestaurantsList(dynamic formData ,{int page = 1}) async {
    // Make network request with pagination parameters
    // You might need to update your API endpoint to support pagination
    final response = await _network.postRequest(
      endPoint: '/favourite-store-get/$page',
      formData: formData
    );

    if (response != null && response.data is Map<String, dynamic>) {
      final Map<String, dynamic> responseData = response.data;
      return RestaurantsListResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to parse API response');
    }
  }

  Future<RestaurentDealResponse> getFavDealsList(dynamic formData , {int page = 1}) async {
    // Make network request with pagination parameters
    // You might need to update your API endpoint to support pagination
    final response = await _network.postRequest(
      endPoint: '/favourite-deal-get/$page',
      formData: formData
    );

    if (response != null && response.data is Map<String, dynamic>) {
      final Map<String, dynamic> responseData = response.data;
      return RestaurentDealResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to parse API response');
    }
  }

  Future<RestaurantsListResponse> getClosestRestaurantsList(
      int filterId, dynamic formData,
      {int page = 1}) async {
    try {
      final response = await _network.postRequest(
          endPoint: '/closed-resturent/$filterId/$page',
          // Replace with your actual API endpoint
          formData: formData);

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

  Future<RestaurentDealResponse> getRestaurantsDealsList(
      int? restaurantId, dynamic formData,
      {int page = 1}) async {
    try {
      final response = await _network.postRequest(
          endPoint: '/get-deal/${restaurantId}/$page',
          // Replace with your actual API endpoint
          formData: formData);

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

  Future<RestaurentDealResponse> getLastMinuteDealsList(int filterId,
  dynamic formData,{int page = 1}) async {
    try {
      final response = await _network.postRequest(
        endPoint: '/last-minute-deal/$filterId/$page', // Replace with your actual API endpoint
formData: formData
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

  Future<RestaurentDealResponse> getCollectTomorrowList(int filterId,
      dynamic formData,{int page = 1}) async {
    try {
      final response = await _network.postRequest(
        endPoint: '/tomorrow-deal-data/$filterId/$page', // Replace with your actual API endpoint
      formData: formData
      );

      print("Collect Tomorrow's Deal response : ${response}");

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

  Future<HomeItemsListingResponse> getHomePageList({int page = 1}) async {
    try {
      final response = await _network.getRequest(
        endPoint: '/home-data', // Replace with your actual API endpoint
      );

      print("Home Page's  response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return HomeItemsListingResponse.fromJson(responseData);
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
