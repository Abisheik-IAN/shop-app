
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopapp_multiplatform/model/cart_model.dart';
import 'package:shopapp_multiplatform/model/product_model.dart';
import '../../model/order_model.dart';
import 'base_order_repo.dart';

class OrderRepo extends FetchOrderRepo{
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late QuerySnapshot querySnapshot;
  List<OrdersModel> data = [];
  List products=[];
  late OrdersModel singledata;
  @override
  Future<void> addCartOrder(int id,List<CartModel> product,int totalAmount) async {
    for(int i=0;i<product.length;i++){
      var data={
        "name":product[i].name!,
        "offer_price":product[i].offerPrice!,
        "price":product[i].price!,
        "product_id":product[i].id!,
        "product_img":product[i].productImg!,
        "quantity":product[i].quantity!
      };
      products.add(data);
    }
    _firebaseFirestore.collection('orders').doc(id.toString()).set({'order_id':id,'products':products,'total_amount':totalAmount,'timestamp':FieldValue.serverTimestamp()});
  }

  @override
  Future<List<OrdersModel>> getAllOrders() async {
    querySnapshot = await _firebaseFirestore.collection('orders').get();
    print(querySnapshot.docs.length);
    data=querySnapshot.docs.map((e) => OrdersModel.fromSnapshot(e)).toList();

    return data;
  }

  @override
  Future<void> addSingleOrder(int id, ProductModel product, int totalAmount) async {

      var data={
        "name":product.name!,
        "offer_price":product.offerPrice!,
        "price":product.price!,
        "product_id":product.id!,
        "product_img":product.productImg!,
        "quantity":1
      };
      products.add(data);

    _firebaseFirestore.collection('orders').doc(id.toString())
        .set({'order_id':id,'products':products,'total_amount':totalAmount,'timestamp':FieldValue.serverTimestamp()});
  }

  @override
  Future<void> deleteCartItem(List<CartModel> product) async {
    for (int i = 0; i < product.length; i++) {
      final Snapshot = (await _firebaseFirestore.collection('cart').doc(
          product[i].id).get());
      if (Snapshot.exists) {
        try {
          await _firebaseFirestore.collection("cart")
              .doc(product[i].id)
              .delete();
        } catch (e) {
          print(e);
        }
      }
    }
  }

  @override
  Future<OrdersModel> getSingleOrders(int orderid) async {
    final querySnapshot = await _firebaseFirestore.collection('orders').doc(orderid.toString()).get();

    singledata=OrdersModel.fromSnapshot(querySnapshot);
    print(singledata.products!.length);

    return singledata;
  }

  @override
  Future<void> addBuyagainOrder(int id, List<Products> product, int totalAmount) async {
    for(int i=0;i<product.length;i++){
      var data={
        "name":product[i].name!,
        "offer_price":product[i].offerPrice!,
        "price":product[i].price!,
        "product_id":product[i].productId!,
        "product_img":product[i].productImg!,
        "quantity":product[i].quantity!
      };
      products.add(data);
    }
    _firebaseFirestore.collection('orders').doc(id.toString()).set({'order_id':id,'products':products,'total_amount':totalAmount,'timestamp':FieldValue.serverTimestamp()});

  }

}