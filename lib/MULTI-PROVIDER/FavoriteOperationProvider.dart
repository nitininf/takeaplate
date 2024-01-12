
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:takeaplate/Response_Model/ForgotPasswordResponse.dart';
import '../NETWORKS/network.dart';
import '../Response_Model/DeleteAccountResponse.dart';
import '../Response_Model/EditProfileResponse.dart';
import '../Response_Model/FavAddedResponse.dart';
import '../Response_Model/FavDeleteResponse.dart';
import '../Response_Model/LogInResponse.dart';
import '../Response_Model/RegisterResponse.dart';
import '../Response_Model/UploadImageResponse.dart';
import '../UTILS/request_string.dart';
import '../UTILS/utils.dart';

class FavoriteOperationProvider extends ChangeNotifier {
  final Network _network = Network();


  List<int> _favoriteIds = []; // Keep track of favorite item IDs

  List<int> get favoriteIds => _favoriteIds;

  bool isFavorite(int itemId) {
    return _favoriteIds.contains(itemId);
  }


  Future<FavAddedResponse> AddToFavoriteStore(int storeId,dynamic formData) async {

    try {
      final response = await _network.postRequest(
        endPoint: '/favourite-store/$storeId', // Replace with your actual API endpoint
        formData: formData,
      );

      print("my response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return FavAddedResponse.fromJson(responseData);
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

  Future<FavDeleteResponse> RemoveFromFavoriteStore(int storeId) async {


    try {
      final response = await _network.deleteRequest(
        endPoint: '/favourite-store-delete/$storeId', // Replace with your actual API endpoint
      );

      print("my response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return FavDeleteResponse.fromJson(responseData);
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


  Future<FavAddedResponse> AddToFavoriteDeal(int dealId,dynamic formData) async {

    try {
      final response = await _network.postRequest(
        endPoint: '/favourite-deal/$dealId', // Replace with your actual API endpoint
        formData: formData,
      );

      print("my response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return FavAddedResponse.fromJson(responseData);
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

  Future<FavDeleteResponse> RemoveFromFavoriteDeal(int dealId) async {


    try {
      final response = await _network.deleteRequest(
        endPoint: '/favourite-deal-delete/$dealId', // Replace with your actual API endpoint
      );

      print("my response : ${response}");

      if (response != null && response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = response.data;

        return FavDeleteResponse.fromJson(responseData);
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
