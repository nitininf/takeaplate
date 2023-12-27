class UploadImageResponse {
  String? url;
  String? fileType;
  String? type;
  String? message;
  bool? status;

  UploadImageResponse(
      {this.url, this.fileType, this.type, this.message, this.status});

  UploadImageResponse.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    fileType = json['fileType'];
    type = json['type'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['fileType'] = this.fileType;
    data['type'] = this.type;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}