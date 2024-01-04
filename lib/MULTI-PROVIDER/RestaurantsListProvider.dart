import 'package:flutter/cupertino.dart';

import '../NETWORKS/network.dart';
import '../Response_Model/RestaurantsListResponse.dart';

class RestaurantsListProvider extends ChangeNotifier {
  final Network _network = Network();

  Future<RestaurantsListResponse> getRestaurantsList() async {

    try {
      final response = await _network.getRequest(
        endPoint: '/store-list', // Replace with your actual API endpoint

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

}
