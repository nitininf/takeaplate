class ForgotPasswordResponse {
  String? message;
  String? email;
  bool? status;

  ForgotPasswordResponse({this.message, this.email, this.status});

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    email = json['Email'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['Email'] = this.email;
    data['status'] = this.status;
    return data;
  }
}