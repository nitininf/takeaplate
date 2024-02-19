class LoginResponse {
  String? message;
  bool? status;
  Data? data;
  String? token;
  String? fcmToken;

  LoginResponse(
      {this.message, this.status, this.data, this.token, this.fcmToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    data['fcm_token'] = this.fcmToken;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  int? userType;
  int? phoneNo;
  String? dOB;
  String? gender;
  String? userImage;
  int? status;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;
  Notification? notification;
  String? role;
  String? deletedAt;

  Data(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.userType,
        this.phoneNo,
        this.dOB,
        this.gender,
        this.userImage,
        this.status,
        this.fcmToken,
        this.createdAt,
        this.updatedAt,
        this.notification,
        this.role,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    userType = json['user_type'];
    phoneNo = json['phone_no'];
    dOB = json['DOB'];
    gender = json['gender'];
    userImage = json['user_image'];
    status = json['status'];
    fcmToken = json['fcm_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    notification = json['notification'] != null
        ? new Notification.fromJson(json['notification'])
        : null;
    role = json['role'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['user_type'] = this.userType;
    data['phone_no'] = this.phoneNo;
    data['DOB'] = this.dOB;
    data['gender'] = this.gender;
    data['user_image'] = this.userImage;
    data['status'] = this.status;
    data['fcm_token'] = this.fcmToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.notification != null) {
      data['notification'] = this.notification!.toJson();
    }
    data['role'] = this.role;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Notification {
  int? deal;
  int? meal;
  int? store;
  int? broadcastNotification;

  Notification({this.deal, this.meal, this.store, this.broadcastNotification});

  Notification.fromJson(Map<String, dynamic> json) {
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