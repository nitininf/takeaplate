import 'package:flutter/cupertino.dart';
import 'package:take_a_plate/Response_Model/RestaurantDealResponse.dart';

import '../NETWORKS/network.dart';

import '../Response_Model/CategoryFilterResponse.dart';
import '../Response_Model/HomeItemsListingResponse.dart';
import '../Response_Model/ProfilePageResponse.dart';
import '../Response_Model/RestaurantsListResponse.dart';

class HomeDataListProvider extends ChangeNotifier {
  final Network _network = Network();

  Future<HomeItemsListingResponse> getHomePageList(
      int filterId, dynamic formData,
      {int page = 1}) async {
    try {
      final response = await _network.postRequest(
          endPoint: '/home-data/$filterId',
          // Replace with your actual API endpoint
          formData: formData);

      print("Home Page's response : ${response}");

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

  Future<ProfilePageResponse> getProfilePageData(dynamic formData ,{int page = 1}) async {
    try {
      final response = await _network.postRequest(
        endPoint: '/profile-data', // Replace with your actual API endpoint
        formData: formData
      );

      print("Profile Page's response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return ProfilePageResponse.fromJson(responseData);
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

  Future<CategoryFilterResponse> getCategoryFilterData({int page = 1}) async {
    try {
      final response = await _network.getRequest(
        endPoint: '/category-search', // Replace with your actual API endpoint
      );

      print("Filter response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return CategoryFilterResponse.fromJson(responseData);
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
