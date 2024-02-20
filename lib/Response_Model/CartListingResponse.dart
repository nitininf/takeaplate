class CartListingResponse {
  bool? status;
  String? message;
  List<CartItems>? cartItems;
  int? totalPrice;

  CartListingResponse({
    this.status,
    this.message,
    this.cartItems,
    this.totalPrice,
  });

  CartListingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(CartItems.fromJson(v));
      });
    }
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (cartItems != null) {
      data['cart_items'] = cartItems!.map((v) => v.toJson()).toList();
    }
    data['total_price'] = totalPrice;
    return data;
  }

  List<int> getAllDealIds() {
    List<int> dealIds = [];
    if (cartItems != null) {
      dealIds = cartItems!.map((item) => item.dealId!).toList();
    }
    return dealIds;
  }

  List<int> getAllStoreIds() {
    List<int> storeIds = [];
    if (cartItems != null) {
      storeIds = cartItems!.map((item) => item.storeId!).toList();
    }
    return storeIds;
  }
}

class CartItems {
  int? cartId;
  int? dealId;
  String? dealName;
  String? dealImage;
  int? storeId;
  String? storeName;
  int? quantity;
  String? price;
  int? subtotal;

  CartItems({
    this.cartId,
    this.dealId,
    this.dealName,
    this.dealImage,
    this.storeId,
    this.storeName,
    this.quantity,
    this.price,
    this.subtotal,
  });

  CartItems.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    dealId = json['deal_id'];
    dealName = json['deal_name'];
    dealImage = json['deal_image'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    quantity = json['quantity'];
    price = json['price'];
    subtotal = json['subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = cartId;
    data['deal_id'] = dealId;
    data['deal_name'] = dealName;
    data['deal_image'] = dealImage;
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['quantity'] = quantity;
    data['price'] = price;
    data['subtotal'] = subtotal;
    return data;
  }
}
