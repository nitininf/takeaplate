class RestaurentDealResponse {
  bool? status;
  String? message;
  List<dealData>? data;
  int? currentPage;
  int? perPage;
  int? total;
  int? lastPage;
  String? nextPageUrl;
  String? prevPageUrl;

  RestaurentDealResponse(
      {this.status,
        this.message,
        this.data,
        this.currentPage,
        this.perPage,
        this.total,
        this.lastPage,
        this.nextPageUrl,
        this.prevPageUrl});

  RestaurentDealResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <dealData>[];
      json['data'].forEach((v) {
        data!.add(new dealData.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    perPage = json['perPage'];
    total = json['total'];
    lastPage = json['lastPage'];
    nextPageUrl = json['nextPageUrl'];
    prevPageUrl = json['prevPageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = this.currentPage;
    data['perPage'] = this.perPage;
    data['total'] = this.total;
    data['lastPage'] = this.lastPage;
    data['nextPageUrl'] = this.nextPageUrl;
    data['prevPageUrl'] = this.prevPageUrl;
    return data;
  }
}

class dealData {
  int? id;
  int? storeId;
  String? name;
  String? category;
  String? price;
  String? description;
  String? allergens;
  String? profileImage;
  String? frequency;
  String? recurrentOrder;
  String? pickupTime;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? collectTomorrow;
  bool? favourite;
  String? averageRating;
  CustomTime? customTime;
  Store? store;

  dealData(
      {this.id,
        this.storeId,
        this.name,
        this.category,
        this.price,
        this.description,
        this.allergens,
        this.profileImage,
        this.frequency,
        this.recurrentOrder,
        this.pickupTime,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.collectTomorrow,
        this.favourite,
        this.averageRating,
        this.customTime,
        this.store});

  dealData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    name = json['name'];
    category = json['category'];
    price = json['price'];
    description = json['description'];
    allergens = json['allergens'];
    profileImage = json['profile_image'];
    frequency = json['frequency'];
    recurrentOrder = json['recurrent_order'];
    pickupTime = json['pickup_time'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    collectTomorrow = json['collect_tomorrow'];
    favourite = json['favourite'];
    averageRating = json['average_rating'];
    customTime = json['custom_time'] != null
        ? new CustomTime.fromJson(json['custom_time'])
        : null;
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['name'] = this.name;
    data['category'] = this.category;
    data['price'] = this.price;
    data['description'] = this.description;
    data['allergens'] = this.allergens;
    data['profile_image'] = this.profileImage;
    data['frequency'] = this.frequency;
    data['recurrent_order'] = this.recurrentOrder;
    data['pickup_time'] = this.pickupTime;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['collect_tomorrow'] = this.collectTomorrow;
    data['favourite'] = this.favourite;
    data['average_rating'] = this.averageRating;
    if (this.customTime != null) {
      data['custom_time'] = this.customTime!.toJson();
    }
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    return data;
  }
}

class CustomTime {
  int? id;
  String? days;
  String? startTime;
  String? endTime;
  int? dealId;
  String? createdAt;
  String? updatedAt;

  CustomTime(
      {this.id,
        this.days,
        this.startTime,
        this.endTime,
        this.dealId,
        this.createdAt,
        this.updatedAt});

  CustomTime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    days = json['days'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    dealId = json['deal_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['days'] = this.days;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['deal_id'] = this.dealId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Store {
  int? id;
  String? name;
  String? address;
  String? email;
  String? phoneNo;
  String? category;
  String? profileImage;
  String? description;
  String? bannerImage;
  String? pin;
  OpeningHour? openingHour;
  PickupTime? pickupTime;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Store(
      {this.id,
        this.name,
        this.address,
        this.email,
        this.phoneNo,
        this.category,
        this.profileImage,
        this.description,
        this.bannerImage,
        this.pin,
        this.openingHour,
        this.pickupTime,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    email = json['email'];
    phoneNo = json['phone_no'];
    category = json['category'];
    profileImage = json['profile_image'];
    description = json['description'];
    bannerImage = json['banner_image'];
    pin = json['pin'];
    openingHour = json['opening_hour'] != null
        ? new OpeningHour.fromJson(json['opening_hour'])
        : null;
    pickupTime = json['pickup_time'] != null
        ? new PickupTime.fromJson(json['pickup_time'])
        : null;
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['category'] = this.category;
    data['profile_image'] = this.profileImage;
    data['description'] = this.description;
    data['banner_image'] = this.bannerImage;
    data['pin'] = this.pin;
    if (this.openingHour != null) {
      data['opening_hour'] = this.openingHour!.toJson();
    }
    if (this.pickupTime != null) {
      data['pickup_time'] = this.pickupTime!.toJson();
    }
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class OpeningHour {
  Friday? friday;
  Friday? monday;
  Friday? sunday;
  Friday? tuesday;
  Friday? saturday;
  Friday? thursday;
  Friday? wednesday;

  OpeningHour(
      {this.friday,
        this.monday,
        this.sunday,
        this.tuesday,
        this.saturday,
        this.thursday,
        this.wednesday});

  OpeningHour.fromJson(Map<String, dynamic> json) {
    friday =
    json['Friday'] != null ? new Friday.fromJson(json['Friday']) : null;
    monday =
    json['Monday'] != null ? new Friday.fromJson(json['Monday']) : null;
    sunday =
    json['Sunday'] != null ? new Friday.fromJson(json['Sunday']) : null;
    tuesday =
    json['Tuesday'] != null ? new Friday.fromJson(json['Tuesday']) : null;
    saturday =
    json['Saturday'] != null ? new Friday.fromJson(json['Saturday']) : null;
    thursday =
    json['Thursday'] != null ? new Friday.fromJson(json['Thursday']) : null;
    wednesday = json['Wednesday'] != null
        ? new Friday.fromJson(json['Wednesday'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.friday != null) {
      data['Friday'] = this.friday!.toJson();
    }
    if (this.monday != null) {
      data['Monday'] = this.monday!.toJson();
    }
    if (this.sunday != null) {
      data['Sunday'] = this.sunday!.toJson();
    }
    if (this.tuesday != null) {
      data['Tuesday'] = this.tuesday!.toJson();
    }
    if (this.saturday != null) {
      data['Saturday'] = this.saturday!.toJson();
    }
    if (this.thursday != null) {
      data['Thursday'] = this.thursday!.toJson();
    }
    if (this.wednesday != null) {
      data['Wednesday'] = this.wednesday!.toJson();
    }
    return data;
  }
}

class Friday {
  String? end;
  String? start;
  bool? enabled;

  Friday({this.end, this.start, this.enabled});

  Friday.fromJson(Map<String, dynamic> json) {
    end = json['end'];
    start = json['start'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['end'] = this.end;
    data['start'] = this.start;
    data['enabled'] = this.enabled;
    return data;
  }
}

class PickupTime {
  String? name;
  String? endTime;
  String? startTime;
  String? enablePickupTime;

  PickupTime({this.name, this.endTime, this.startTime, this.enablePickupTime});

  PickupTime.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    endTime = json['end_time'];
    startTime = json['start_time'];
    enablePickupTime = json['enable_pickup_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['end_time'] = this.endTime;
    data['start_time'] = this.startTime;
    data['enable_pickup_time'] = this.enablePickupTime;
    return data;
  }
}