import 'package:shopapp_multiplatform/model/cart_model.dart';
import 'package:shopapp_multiplatform/model/order_model.dart';
import 'package:shopapp_multiplatform/model/product_model.dart';

abstract class FetchOrderRepo{
  Future<List<OrdersModel>> getAllOrders();
  Future<OrdersModel> getSingleOrders(int orderid);
  Future<void> addCartOrder(int id,List<CartModel> product,int totalAmount);
  Future<void> addBuyagainOrder(int id,List<Products> product,int totalAmount);
  Future<void> addSingleOrder(int id,ProductModel product,int totalAmount);
  Future<void> deleteCartItem(List<CartModel> product);
}