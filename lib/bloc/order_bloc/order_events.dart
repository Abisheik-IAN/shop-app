
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopapp_multiplatform/model/cart_model.dart';
import 'package:shopapp_multiplatform/model/order_model.dart';
import 'package:shopapp_multiplatform/model/product_model.dart';

abstract class OrderEvents extends Equatable{
  const OrderEvents();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class OrderLoadingEvents extends OrderEvents{}
class PaymentMethodEvent extends OrderEvents{}
class OrderScreenEvent extends OrderEvents{}
class BillingScreenEvent extends OrderEvents{}
class PaymentMethodNavigationEvent extends OrderEvents{}
class OrderScreenNavigationEvent extends OrderEvents{}
class BillingScreenNavigationEvent extends OrderEvents{}

class SaveAddressEvent extends OrderEvents{
  final String doorNo;
  final String street;
  final String area;
  final String city;
  final String state;
  final String pincode;
  final int phoneNumber;
  SaveAddressEvent({
    required this.doorNo,
    required this.street,
    required this.area,
    required this.city,
    required this.state,
    required this.pincode,
    required this.phoneNumber
});
  @override
  // TODO: implement props
  List<Object?> get props => [doorNo,street,area,city,state,pincode,phoneNumber];
}

class AddOrdersEvent extends OrderEvents{
  final int orderId;
  final List<CartModel>? cartProducts;
  final bool isCart;
  final ProductModel? singleProduct;
  final int totalAmount;
  AddOrdersEvent({
    required this.orderId,
    required this.isCart,
    required this.totalAmount,
    this.cartProducts,
    this.singleProduct
});
@override
  // TODO: implement props
  List<Object?> get props => [orderId,isCart,totalAmount,cartProducts,singleProduct];
}
class LoadOrderEvents extends OrderEvents{}

class UpdateOrderEvents extends OrderEvents{
  final List<OrdersModel> order;

  const UpdateOrderEvents(this.order);

  @override
  // TODO: implement props
  List<Object?> get props => [order];
}
class BuyAgainEvent extends OrderEvents{
  final int orderid;
  final BuildContext context;
  BuyAgainEvent({required this.orderid, required this.context});
}