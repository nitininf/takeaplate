class OrderDetailResponse {
  String? image;
  String? name;
  String? category;
  String? pickUpTime;
  int? rating;
  double? price;
  String? distance;
  String? address;
  String? description;
  List<String>? features;

  OrderDetailResponse(
      {this.image,
        this.name,
        this.category,
        this.pickUpTime,
        this.rating,
        this.price,
        this.distance,
        this.address,
        this.description,
        this.features});

  OrderDetailResponse.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    category = json['category'];
    pickUpTime = json['pickUpTime'];
    rating = json['rating'];
    price = json['price'];
    distance = json['distance'];
    address = json['address'];
    description = json['description'];
    features = json['features'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['category'] = this.category;
    data['pickUpTime'] = this.pickUpTime;
    data['rating'] = this.rating;
    data['price'] = this.price;
    data['distance'] = this.distance;
    data['address'] = this.address;
    data['description'] = this.description;
    data['features'] = this.features;
    return data;
  }
}