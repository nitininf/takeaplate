import 'package:flutter/material.dart';
import '../NETWORKS/network.dart';
import '../Response_Model/FaqResponse.dart';

class FaqProvider extends ChangeNotifier {
  final Network _network = Network();
  int _expandedIndex = -1;
  bool _isDataFetched = false;

  int get expandedIndex => _expandedIndex;

  bool get isDataFetched => _isDataFetched;

  void setExpandedIndex(int index) {
    _expandedIndex = index;
    notifyListeners();
  }

  void setDataFetched() {
    _isDataFetched = true;
    notifyListeners();
  }

  Future<FaqResponse> fetchFaqData() async {
    try {
      final response = await _network.getRequest(
        endPoint: '/faq-list', // Replace with your actual API endpoint
      );

      print("Faq response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;
        return FaqResponse.fromJson(responseData);
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
