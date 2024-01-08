class RestaurentDealResponse {
  bool? status;
  String? message;
  List<dealData>? data;

  RestaurentDealResponse({this.status, this.message, this.data});

  RestaurentDealResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <dealData>[];
      json['data'].forEach((v) {
        data!.add(new dealData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class dealData {
  int? id;
  int? storeId;
  String? name;
  String? category;
  String? price;
  String? description;
  String? allergens;
  String? profileImage;
  String? frequency;
  String? recurrentOrder;
  String? pickupTime;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  CustomTime? customTime;

  dealData(
      {this.id,
        this.storeId,
        this.name,
        this.category,
        this.price,
        this.description,
        this.allergens,
        this.profileImage,
        this.frequency,
        this.recurrentOrder,
        this.pickupTime,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.customTime});

  dealData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    name = json['name'];
    category = json['category'];
    price = json['price'];
    description = json['description'];
    allergens = json['allergens'];
    profileImage = json['profile_image'];
    frequency = json['frequency'];
    recurrentOrder = json['recurrent_order'];
    pickupTime = json['pickup_time'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customTime = json['custom_time'] != null
        ? new CustomTime.fromJson(json['custom_time'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['name'] = this.name;
    data['category'] = this.category;
    data['price'] = this.price;
    data['description'] = this.description;
    data['allergens'] = this.allergens;
    data['profile_image'] = this.profileImage;
    data['frequency'] = this.frequency;
    data['recurrent_order'] = this.recurrentOrder;
    data['pickup_time'] = this.pickupTime;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customTime != null) {
      data['custom_time'] = this.customTime!.toJson();
    }
    return data;
  }
}

class CustomTime {
  int? id;
  String? days;
  String? startTime;
  String? endTime;
  int? dealId;
  String? createdAt;
  String? updatedAt;

  CustomTime(
      {this.id,
        this.days,
        this.startTime,
        this.endTime,
        this.dealId,
        this.createdAt,
        this.updatedAt});

  CustomTime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    days = json['days'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    dealId = json['deal_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['days'] = this.days;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['deal_id'] = this.dealId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}