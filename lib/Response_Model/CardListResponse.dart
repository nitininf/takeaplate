class CardListResponse {
  bool? status;
  List<CardData>? data;

  CardListResponse({this.status, this.data});

  CardListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CardData>[];
      json['data'].forEach((v) {
        data!.add(new CardData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardData {
  int? id;
  String? cardNumber;
  String? imagePath;
  String? cardType;

  CardData({this.id, this.cardNumber, this.imagePath, this.cardType});

  CardData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardNumber = json['card_number'];
    imagePath = json['image_path'];
    cardType = json['card_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['card_number'] = this.cardNumber;
    data['image_path'] = this.imagePath;
    data['card_type'] = this.cardType;
    return data;
  }
}