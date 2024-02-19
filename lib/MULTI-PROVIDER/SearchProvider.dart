import 'package:flutter/cupertino.dart';
import 'package:take_a_plate/Response_Model/RestaurantDealResponse.dart';

import '../NETWORKS/network.dart';

import '../Response_Model/HomeItemsListingResponse.dart';
import '../Response_Model/ProfilePageResponse.dart';
import '../Response_Model/RestaurantsListResponse.dart';
import '../Response_Model/SearchHistoryResponse.dart';
import '../Response_Model/SearchQueryResponse.dart';
import '../Response_Model/SearchResponse.dart';

class SearchProvider extends ChangeNotifier {
  final Network _network = Network();

  Future<SearchResponse> getSearchResult(Map<String, String> formData,
      {int page = 1}) async {
    try {
      final response = await _network.postRequest(
          endPoint: '/store-data-search',
          // isLoader: false,
          // Replace with your actual API endpoint
          formData: formData);

      print("Search Page's response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return SearchResponse.fromJson(responseData);
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



  Future<SearchQueryResponse> getSearchQueryResultList(Map<String, Object?> formData,{int page = 1}) async {
    // Make network request with pagination parameters
    // You might need to update your API endpoint to support pagination
    final response = await _network.postRequest(
      endPoint: '/all-search/$page',
      formData: formData
    );

    if (response != null && response.data is Map<String, dynamic>) {
      final Map<String, dynamic> responseData = response.data;
      return SearchQueryResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to parse API response');
    }
  }




  Future<SearchHistoryResponse> getSearchHistoryList({int page = 1}) async {
    // Make network request with pagination parameters
    // You might need to update your API endpoint to support pagination
    final response = await _network.getRequest(
      endPoint: '/get-search-history/$page',
    );

    if (response != null && response.data is Map<String, dynamic>) {
      final Map<String, dynamic> responseData = response.data;
      return SearchHistoryResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to parse API response');
    }
  }

}
