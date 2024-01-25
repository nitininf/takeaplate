import 'package:flutter/cupertino.dart';
import 'package:takeaplate/Response_Model/RestaurantDealResponse.dart';

import '../NETWORKS/network.dart';

import '../Response_Model/HomeItemsListingResponse.dart';
import '../Response_Model/ProfilePageResponse.dart';
import '../Response_Model/RestaurantsListResponse.dart';
import '../Response_Model/SearchResponse.dart';

class SearchProvider extends ChangeNotifier {
  final Network _network = Network();

  Future<SearchResponse> getSearchResult(Map<String, String> formData,
      {int page = 1}) async {
    try {
      final response = await _network.postRequest(
          endPoint: '/store-data-search',
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

}
