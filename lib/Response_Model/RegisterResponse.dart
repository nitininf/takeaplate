class RegisterResponse {
  String? message;
  bool? status;
  Data? data;
  String? token;

  RegisterResponse({this.message, this.status, this.data, this.token});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Data {
  String? name;
  String? email;
  String? phoneNo;
  String? dOB;
  String? gender;
  String? userImage;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.name,
        this.email,
        this.phoneNo,
        this.dOB,
        this.gender,
        this.userImage,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    dOB = json['DOB'];
    gender = json['gender'];
    userImage = json['user_image'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone_no'] = phoneNo;
    data['DOB'] = dOB;
    data['gender'] = gender;
    data['user_image'] = userImage;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}