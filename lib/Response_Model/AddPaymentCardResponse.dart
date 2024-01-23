class AddPaymentCardResponse {
  String? message;
  bool? status;

  AddPaymentCardResponse({this.message, this.status});

  AddPaymentCardResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}