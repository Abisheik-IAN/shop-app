

import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String? imageUrl;

  BannerModel({this.imageUrl});

  BannerModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
  }
  static BannerModel fromSnapshot(DocumentSnapshot snap){
    BannerModel bannerModel=BannerModel(
      imageUrl: snap['image_url'],
    );
    return bannerModel;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    return data;
  }
}