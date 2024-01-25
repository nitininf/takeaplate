import 'RestaurantDealResponse.dart';
import 'RestaurantsListResponse.dart';

class SearchResponse {
  String? message;
  bool? status;
  List<StoreData>? closestRestaurant;
  List<StoreData>? restaurant;
  List<DealData>? lastMinuteDeals;
  List<DealData>? collectTomorrowDeals;

  SearchResponse(
      {this.message,
        this.status,
        this.closestRestaurant,
        this.restaurant,
        this.lastMinuteDeals,
        this.collectTomorrowDeals});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['closestRestaurant'] != null) {
      closestRestaurant = <StoreData>[];
      json['closestRestaurant'].forEach((v) {
        closestRestaurant!.add(new StoreData.fromJson(v));
      });
    }
    if (json['restaurant'] != null) {
      restaurant = <StoreData>[];
      json['restaurant'].forEach((v) {
        restaurant!.add(new StoreData.fromJson(v));
      });
    }
    if (json['lastMinuteDeals'] != null) {
      lastMinuteDeals = <DealData>[];
      json['lastMinuteDeals'].forEach((v) {
        lastMinuteDeals!.add(new DealData.fromJson(v));
      });
    }
    if (json['collectTomorrowDeals'] != null) {
      collectTomorrowDeals = <DealData>[];
      json['collectTomorrowDeals'].forEach((v) {
        collectTomorrowDeals!.add(new DealData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.closestRestaurant != null) {
      data['closestRestaurant'] =
          this.closestRestaurant!.map((v) => v.toJson()).toList();
    }
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.map((v) => v.toJson()).toList();
    }
    if (this.lastMinuteDeals != null) {
      data['lastMinuteDeals'] =
          this.lastMinuteDeals!.map((v) => v.toJson()).toList();
    }
    if (this.collectTomorrowDeals != null) {
      data['collectTomorrowDeals'] =
          this.collectTomorrowDeals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}