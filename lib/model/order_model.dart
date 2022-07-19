import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersModel {
  int? orderId;
  List<Products>? products;
  int? totalAmount;
  Timestamp? timestamp;

  OrdersModel({this.orderId, this.products, this.totalAmount,this.timestamp});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
    timestamp=json['timestamp'];
  }

  static OrdersModel fromSnapshot(DocumentSnapshot snap){
    List<Products> pro=[];
    if (snap['products'] != null) {
      pro = <Products>[];
      snap['products'].forEach((v) {
        pro.add(new Products.fromJson(v));
      });
    }
    // print(snap['name']);
    OrdersModel ordersModel=OrdersModel(
        orderId: snap['order_id'],
        products: pro,
        totalAmount: snap['total_amount'],
        timestamp: snap['timestamp'],

    );
    return ordersModel;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = this.totalAmount;
    data['timestamp']= this.timestamp;
    return data;
  }
}

class Products {
  String? name;
  int? offerPrice;
  int? price;
  String? productId;
  String? productImg;
  int? quantity;

  Products(
      {this.name,
        this.offerPrice,
        this.price,
        this.productId,
        this.productImg,
        this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    offerPrice = json['offer_price'];
    price = json['price'];
    productId = json['product_id'];
    productImg = json['product_img'];
    quantity = json['quantity'];
  }
  static Products fromSnapshot(DocumentSnapshot snap){
    // print(snap['name']);
    Products products=Products(

        name :snap['name'],
        offerPrice:snap['offer_price'],
        price : snap['price'],
        productId : snap['product_id'],
        productImg : snap['product_img'],
        quantity : snap['quantity']

    );
    return products;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['offer_price'] = this.offerPrice;
    data['price'] = this.price;
    data['product_id'] = this.productId;
    data['product_img'] = this.productImg;
    data['quantity'] = this.quantity;
    return data;
  }
}

