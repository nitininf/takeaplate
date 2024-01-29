import 'RestaurantDealResponse.dart';
import 'RestaurantsListResponse.dart';

class SearchQueryResponse {
  String? message;
  bool? status;
  List<StoreData>? stores;
  List<DealData>? deals;


  SearchQueryResponse(
      {this.message,
        this.status,
        this.stores,
        this.deals,
    });

  SearchQueryResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['stores'] != null) {
      stores = <StoreData>[];
      json['stores'].forEach((v) {
        stores!.add(new StoreData.fromJson(v));
      });
    }
    if (json['deals'] != null) {
      deals = <DealData>[];
      json['deals'].forEach((v) {
        deals!.add(new DealData.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.stores != null) {
      data['stores'] = this.stores!.map((v) => v.toJson()).toList();
    }
    if (this.deals != null) {
      data['deals'] = this.deals!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
