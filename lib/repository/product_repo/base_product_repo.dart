

import '../../model/product_model.dart';

abstract class FetchProductRepo{
  Future<List<ProductModel>> getAllProducts();
  Future<void> addProducts(String name,int offerprice,int price,String productimg);
  Future<List<ProductModel>> getRecentProducts();
}