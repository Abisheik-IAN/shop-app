import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  int? price;
  String? id;
  String? name;
  // String? timestamp;
  String? productImg;
  int? offerPrice;
  int? quantity;

  CartModel(
      {this.price,
        this.id,
        this.name,
        // this.timestamp,
        this.productImg,
        this.offerPrice,
        this.quantity});

  CartModel.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    id = json['id'];
    name = json['name'];
    // timestamp = json['timestamp'];
    productImg = json['product_img'];
    offerPrice = json['offer_price'];
    quantity = json['quantity'];
  }

  static CartModel fromSnapshot(DocumentSnapshot snap){
    // print(snap['name']);
    CartModel cartModel=CartModel(

      id:snap['id'],
      name: snap['name'],
      offerPrice: snap['offer_price'],
      price: snap['price'],
      productImg: snap['product_img'],
      quantity: snap['quantity']

    );
    return cartModel;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['id'] = this.id;
    data['name'] = this.name;
    // data['timestamp'] = this.timestamp;
    data['product_img'] = this.productImg;
    data['offer_price'] = this.offerPrice;
    data['quantity'] = this.quantity;
    return data;
  }
}