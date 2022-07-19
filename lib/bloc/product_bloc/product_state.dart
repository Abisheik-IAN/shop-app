import 'package:equatable/equatable.dart';

import '../../model/product_model.dart';


abstract class ProductState extends Equatable{
  const ProductState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductLoadingState extends ProductState{}

class ProductLoadedState extends ProductState{
  final List<ProductModel> product;
  const ProductLoadedState({required this.product});
  @override
  // TODO: implement props
  List<Object?> get props => [product];
}
class AddProductLoadingState extends ProductState{}
class AddProductLoadedState extends ProductState{
}

class RecentProductLoadingState extends ProductState{}
class RecentProductLoadedState extends ProductState{
  final List<ProductModel> product;
  const RecentProductLoadedState({required this.product});
  @override
  // TODO: implement props
  List<Object?> get props => [product];
}
class AddProductNavigationState extends ProductState{}
class AddProductWidgetState extends ProductState {
  final bool name;
  final bool price;
  final bool offerprice;
  final bool imageurl;

  AddProductWidgetState({
    required this.name,
    required this.price,
    required this.offerprice,
    required this.imageurl
  });
  @override
  // TODO: implement props
  List<Object?> get props => [name,price,offerprice,imageurl];
}

class FieldValidationErrorState extends ProductState{/// Add new product field validation state...
  final bool name;
  final bool price;
  final bool offerprice;
  final bool imageurl;
  FieldValidationErrorState({
    required this.name,
    required this.price,
    required this.offerprice,
    required this.imageurl
});
  @override
  // TODO: implement props
  List<Object?> get props => [name,price,offerprice,imageurl];
}
class FieldValidationSuccessState extends ProductState{}

class PriceDiffError extends ProductState{}