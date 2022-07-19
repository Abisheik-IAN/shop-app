import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/cart_model.dart';
import '../../model/product_model.dart';
import 'base_cart_item_repo.dart';


class CartRepo extends BaseCartRepo{
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late QuerySnapshot querySnapshot;
  List<CartModel> data=[];
  late ProductModel singleProduct;
  @override
  Future<void> addCartItem(String id,String name, int offerprice, int price, String productimg) async {
    try{
      final snapshot=await _firebaseFirestore.collection("cart").doc(id).get();
      if(snapshot.exists){
        _firebaseFirestore.collection("cart").doc(id).update({'quantity':(snapshot['quantity']+1)});
      }else{
        await _firebaseFirestore
            .collection("cart").doc(id)
            .set({'id':id,'name':name,'offer_price':offerprice,'price':price,'product_img':productimg,'quantity':1,'timestamp':FieldValue.serverTimestamp()});
      }

    }catch(e){
      print(e);
    }
  }

  @override
  Future<List<CartModel>> getAllCartItems() async {
    querySnapshot = await _firebaseFirestore.collection('cart').get();

    data=querySnapshot.docs.map((e) => CartModel.fromSnapshot(e)).toList();
    return data;
  }

  @override
  Future<void> deleteCartItem(String id) async{
    try{
      await _firebaseFirestore.collection("cart").doc(id).delete();
    }catch(e){
      print(e);
    }
  }

  @override
  Future<void> decreaseCartItem(String id) async {
    final snapshot=await _firebaseFirestore.collection("cart").doc(id).get();
    if(snapshot.exists){
      if(snapshot['quantity']>1){
        _firebaseFirestore.collection("cart").doc(id).update({'quantity':(snapshot['quantity']-1)});
      }
    }

  }

  @override
  Future<ProductModel> getSingleProduct(String id) async {
    final querySnapshot=await _firebaseFirestore.collection("products").doc(id.trim()).get();
    singleProduct=ProductModel.fromSnapshot(querySnapshot) ;
    return singleProduct;
  }

}