import 'package:flutter/cupertino.dart';
import 'package:takeaplate/Response_Model/RestaurantDealResponse.dart';

import '../NETWORKS/network.dart';

import '../Response_Model/HomeItemsListingResponse.dart';
import '../Response_Model/RestaurantsListResponse.dart';

class HomeDataListProvider extends ChangeNotifier {
  final Network _network = Network();


  Future<HomeItemsListingResponse> getHomePageList({int page = 1}) async {

    try {
      final response = await _network.getRequest(
        endPoint: '/home-data', // Replace with your actual API endpoint

      );

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



}
