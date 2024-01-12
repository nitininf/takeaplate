class FavDeleteResponse {
  String? message;
  DelFav? data;
  bool? status;

  FavDeleteResponse({this.message, this.data, this.status});

  FavDeleteResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new DelFav.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class DelFav {
  int? id;
  int? userId;
  int? storeId;
  int? favourite;
  String? createdAt;
  String? updatedAt;

  DelFav(
      {this.id,
        this.userId,
        this.storeId,
        this.favourite,
        this.createdAt,
        this.updatedAt});

  DelFav.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    storeId = json['store_id'];
    favourite = json['favourite'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['store_id'] = this.storeId;
    data['favourite'] = this.favourite;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}