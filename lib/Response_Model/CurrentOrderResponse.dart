import 'ProfilePageResponse.dart';

class CurrentOrderResponse {
  String? message;
  List<CurrentDeal>? data;
  bool? status;
  int? currentPage;
  int? perPage;
  int? total;
  int? lastPage;
  String? nextPageUrl;
  String? prevPageUrl;

  CurrentOrderResponse(
      {this.message,
        this.data,
        this.status,
        this.currentPage,
        this.perPage,
        this.total,
        this.lastPage,
        this.nextPageUrl,
        this.prevPageUrl});

  CurrentOrderResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <CurrentDeal>[];
      json['data'].forEach((v) {
        data!.add(new CurrentDeal.fromJson(v));
      });
    }
    status = json['status'];
    currentPage = json['currentPage'];
    perPage = json['perPage'];
    total = json['total'];
    lastPage = json['lastPage'];
    nextPageUrl = json['nextPageUrl'];
    prevPageUrl = json['prevPageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['currentPage'] = this.currentPage;
    data['perPage'] = this.perPage;
    data['total'] = this.total;
    data['lastPage'] = this.lastPage;
    data['nextPageUrl'] = this.nextPageUrl;
    data['prevPageUrl'] = this.prevPageUrl;
    return data;
  }
}
