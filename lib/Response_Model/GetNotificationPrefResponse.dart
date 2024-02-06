class GetNotificationPrefResponse {
  String? message;
  bool? status;
  Data? data;

  GetNotificationPrefResponse({this.message, this.status, this.data});

  GetNotificationPrefResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? deal;
  int? meal;
  int? store;
  int? broadcastNotification;

  Data({this.deal, this.meal, this.store, this.broadcastNotification});

  Data.fromJson(Map<String, dynamic> json) {
    deal = json['deal'];
    meal = json['meal'];
    store = json['store'];
    broadcastNotification = json['broadcast_notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal'] = this.deal;
    data['meal'] = this.meal;
    data['store'] = this.store;
    data['broadcast_notification'] = this.broadcastNotification;
    return data;
  }
}