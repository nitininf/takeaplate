class PrivacyPolicyResponse {
  String? data;
  bool? status;
  String? message;

  PrivacyPolicyResponse({this.data, this.status, this.message});

  PrivacyPolicyResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}