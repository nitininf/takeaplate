class FavAddedResponse {
  String? message;
  bool? status;
  int? favourite;
  FavData? data;

  FavAddedResponse({this.message, this.status, this.favourite, this.data});

  FavAddedResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    favourite = json['favourite'];
    data = json['data'] != null ? new FavData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['favourite'] = this.favourite;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class FavData {
  int? userId;
  int? storeId;
  int? favourite;
  String? updatedAt;
  String? createdAt;
  int? id;

  FavData(
      {this.userId,
        this.storeId,
        this.favourite,
        this.updatedAt,
        this.createdAt,
        this.id});

  FavData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    storeId = json['store_id'];
    favourite = json['favourite'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['store_id'] = this.storeId;
    data['favourite'] = this.favourite;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}