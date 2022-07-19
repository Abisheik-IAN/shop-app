import 'package:equatable/equatable.dart';

import '../../model/cart_model.dart';
import '../../model/product_model.dart';


abstract class CartState extends Equatable{
  const CartState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class CartLoadingState extends CartState{}

class CartLoadedState extends CartState{
  final List<CartModel> product;
  const CartLoadedState({required this.product});
  @override
  // TODO: implement props
  List<Object?> get props => [product];
}
class AddToCartLoadingState extends CartState{}
class AddToCartLoadedState extends CartState{
}
class CartCountLoadingState extends CartState{}
class CartCountIncrementState extends CartState{
  final String CartCount;
  const CartCountIncrementState({required this.CartCount});
  @override
  // TODO: implement props
  List<Object?> get props => [CartCount];
}
class CartDeleteItemLoadingState extends CartState{}
class CartDeleteItemLoadedState extends CartState{}
class NavigatetoOrderState extends CartState{}