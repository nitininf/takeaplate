class CartListingResponse {
  bool? status;
  String? message;
  List<CartItems>? cartItems;
  int? totalPrice;

  CartListingResponse(
      {this.status, this.message, this.cartItems, this.totalPrice});

  CartListingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.cartItems != null) {
      data['cart_items'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    data['total_price'] = this.totalPrice;
    return data;
  }
}

class CartItems {
  int? cartId;
  int? dealId;
  String? dealName;
  String? dealImage;
  String? storeName;
  int? quantity;
  String? price;
  int? subtotal;

  CartItems(
      {this.cartId,
        this.dealId,
        this.dealName,
        this.dealImage,
        this.storeName,
        this.quantity,
        this.price,
        this.subtotal});

  CartItems.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    dealId = json['deal_id'];
    dealName = json['deal_name'];
    dealImage = json['deal_image'];
    storeName = json['store_name'];
    quantity = json['quantity'];
    price = json['price'];
    subtotal = json['subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['deal_id'] = this.dealId;
    data['deal_name'] = this.dealName;
    data['deal_image'] = this.dealImage;
    data['store_name'] = this.storeName;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['subtotal'] = this.subtotal;
    return data;
  }
}