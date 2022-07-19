import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String?id;
  String? name;
  int? offerPrice;
  int? price;
  String? productImg;
  String? timestamp;
  String? description;

  ProductModel(
      {
        this.id,
        this.name,
        this.offerPrice,
        this.price,
        this.productImg,
        this.timestamp,
        this.description});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id=json['id'];
    name = json['name'];
    offerPrice = json['offer_price'];
    price = json['price'];
    productImg = json['product_img'];
    description = json['description'];
    timestamp = json['timestamp'];
  }
  static ProductModel fromSnapshot(DocumentSnapshot snap){
    Timestamp timestamp =snap['timestamp'];
    print(timestamp.toDate());
    ProductModel productModel=ProductModel(
      description: snap['description'],
      id:snap['id'],
      name: snap['name'],
      offerPrice: snap['offer_price'],
      price: snap['price'],
      productImg: snap['product_img'],

    );
    return productModel;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id']=id;
    data['name'] = name;
    data['offer_price'] = offerPrice;
    data['price'] = price;
    data['product_img'] = productImg;
    data['description']=description;
    data['timestamp'] = timestamp;
    return data;
  }
}


