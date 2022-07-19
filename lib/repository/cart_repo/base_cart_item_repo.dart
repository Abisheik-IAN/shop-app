
import '../../model/cart_model.dart';
import '../../model/product_model.dart';

abstract class BaseCartRepo{
  Future<List<CartModel>> getAllCartItems();
  Future<void> addCartItem(String id,String name,int offerprice,int price,String productimg);
  Future<void> deleteCartItem(String name);
  Future<void> decreaseCartItem(String id);
  Future<ProductModel> getSingleProduct(String id);
}