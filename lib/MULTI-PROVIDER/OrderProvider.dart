import 'package:flutter/cupertino.dart';
import 'package:takeaplate/Response_Model/RestaurantDealResponse.dart';

import '../NETWORKS/network.dart';

import '../Response_Model/CurrentOrderResponse.dart';
import '../Response_Model/HomeItemsListingResponse.dart';
import '../Response_Model/RestaurantsListResponse.dart';

class OrderProvider extends ChangeNotifier {
  final Network _network = Network();



  Future<RestaurentDealResponse> getPreviousOrderList({int page = 1}) async {

    try {
      final response = await _network.getRequest(
        endPoint: '/previous-order-deal/$page', // Replace with your actual API endpoint

      );

      print("Previous Order response : ${response}");

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


  Future<CurrentOrderResponse> getCurrentOrderList({int page = 1}) async {

    try {
      final response = await _network.getRequest(
        endPoint: '/current-order-deal/$page', // Replace with your actual API endpoint

      );

      print("Previous Order response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return CurrentOrderResponse.fromJson(responseData);
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
