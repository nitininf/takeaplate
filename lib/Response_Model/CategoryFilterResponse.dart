class CategoryFilterResponse {
  String? message;
  bool? status;
  List<FilterData>? data;

  CategoryFilterResponse({this.message, this.status, this.data});

  CategoryFilterResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <FilterData>[];
      json['data'].forEach((v) {
        data!.add(new FilterData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FilterData {
  int? id;
  String? category;

  FilterData({this.id, this.category});

  FilterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    return data;
  }
}