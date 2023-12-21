class LoginResponse {
  String? message;
  bool? status;
  LoginData? data;
  String? token;

  LoginResponse({this.message, this.status, this.data, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class LoginData {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  int? userType;
  int? phoneNo;
  String? dOB;
  String? gender;
  String? userImage;
  int? status;
  Null? fcmToken;
  String? createdAt;
  String? updatedAt;

  LoginData(
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
        this.updatedAt});

  LoginData.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}