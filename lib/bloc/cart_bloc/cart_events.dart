import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../model/product_model.dart';


abstract class CartEvents extends Equatable{
  const CartEvents();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadCartEvents extends CartEvents{}

class UpdateCartEvents extends CartEvents{
  final List<ProductModel> products;

  const UpdateCartEvents(this.products);

  @override
  // TODO: implement props
  List<Object?> get props => [products];
}

class LoadAddCartEvent extends CartEvents{}

class UpdateAddCartEvent extends CartEvents{
  final String id;
  final String name;
  final int offerprice;
  final int price;
  final String productImg;
  const UpdateAddCartEvent({
    required this.id,
    required this.name,
    required this.offerprice,
    required this.price,
    required this.productImg,
  });

  @override
  // TODO: implement props
  List<Object?> get props {  return [id,name,offerprice,price,productImg];}


}
class CartCountLoadingEvent extends CartEvents{}
class CartCountIncrementEvent extends CartEvents{}

class CartDeletetLoadingEvent extends CartEvents{}
class CartDeletetLoadedEvent extends CartEvents{
  final String id;
  CartDeletetLoadedEvent({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
class DecreamentCartEvent extends CartEvents{
  final String id;
  DecreamentCartEvent({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
class NavigatetoOrderEvent extends CartEvents{
  final bool isCart;
  final BuildContext context;
  final String? productId;
  NavigatetoOrderEvent({required this.isCart,required this.context,this.productId});
  @override
  // TODO: implement props
  List<Object?> get props => [isCart];
}