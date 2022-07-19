import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../model/product_model.dart';


abstract class ProductEvents extends Equatable{
  const ProductEvents();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadProductEvents extends ProductEvents{}

class UpdateProductEvents extends ProductEvents{
  final List<ProductModel> products;
  const UpdateProductEvents(this.products);
  @override
  // TODO: implement props
  List<Object?> get props => [products];
}

class LoadAddProductEvent extends ProductEvents{}

class UpdateAddProductEvent extends ProductEvents{
  final String name;
  final int offerprice;
  final int price;
  final String productImg;
  final String timeStamp;
  const UpdateAddProductEvent({
    required this.name,
    required this.offerprice,
    required this.price,
    required this.productImg,
    required this.timeStamp
  });

 @override
  // TODO: implement props
  List<Object?> get props {  return [name,offerprice,price,productImg,timeStamp];}


}
class LoadRecentProductEvents extends ProductEvents{}

class UpdateRecentProductEvents extends ProductEvents{
  final List<ProductModel> products;

  const UpdateRecentProductEvents(this.products);

  @override
  // TODO: implement props
  List<Object?> get props => [products];
}

class AddProductNavigationEvents extends ProductEvents{
  final BuildContext context;
  AddProductNavigationEvents({required this.context});
}
class AddProductWidgetEvent extends ProductEvents{}

class FieldValidationErrorEvent extends ProductEvents{
  final String name;
  final String offerprice;
  final String price;
  final String imageurl;
  FieldValidationErrorEvent({
    required this.name,
    required this.offerprice,
    required this.price,
    required this.imageurl
});
  @override
  // TODO: implement props
  List<Object?> get props => [name,offerprice,price,imageurl];
}
