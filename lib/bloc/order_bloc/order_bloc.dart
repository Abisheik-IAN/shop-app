

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/order_repo/order_repo.dart';
import '../../screens/order_screen.dart';
import 'order_events.dart';
import 'order_state.dart';


class OrderBloc extends Bloc<OrderEvents,OrderState>{
  final OrderRepo _orderRepo;
  OrderBloc({required OrderRepo orderRepo}) : _orderRepo=orderRepo, super(OrderLoadingState()){
    on<LoadOrderEvents>((event, emit) async {
      emit(OrderLoadingState());
      final order = await _orderRepo.getAllOrders();///It get all the product details(name,price,offer_price,Image) from firestore..
      // print("product length" + product.length.toString());
      emit(OrderLoadedState(order: order));
    });
    on<BuyAgainEvent>((event, emit) async {
      int totaloffer=0;
      int totalamount=0;
      final order = await _orderRepo.getSingleOrders(event.orderid);
      if(order.orderId != null){

      final product = order.products;
      for (int i = 0; i < product!.length; i++) {
        var singleProduct = 0;
        var offer = 0;

        singleProduct = product[i].offerPrice! * product[i].quantity!;
        offer =
            (product[i].price! - product[i].offerPrice!) * product[i].quantity!;
        totaloffer = totaloffer + offer;
        totalamount = totalamount + singleProduct;
        emit(OrderScreenState());
        Navigator.push(event.context, MaterialPageRoute(builder: (context) =>
            OrderScreen(orderid: DateTime
                .now()
                .millisecondsSinceEpoch,
              iscart: false,
              isorder: true,
              orderAgainProducts: product,
              totalAmount: totalamount,
              totalOfferAmount: totaloffer,)));
      }

      }
    });
    on<SaveAddressEvent>((event, emit) async {

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('doorNo', event.doorNo);
      await prefs.setString('street', event.street);
      await prefs.setString('area', event.area);
      await prefs.setString('city', event.city);
      await prefs.setString('state', event.state);
      await prefs.setString('pincode', event.pincode);
      await prefs.setInt('phoneNumber', event.phoneNumber);
    });
    on<AddOrdersEvent>((event, emit) async {
      emit(AddOrdersLoadingState());
      if(event.isCart){
        await _orderRepo.addCartOrder(event.orderId, event.cartProducts!, event.totalAmount);
        await _orderRepo.deleteCartItem(event.cartProducts!);
        emit(AddOrdersLoadedState());
      }else{
        await _orderRepo.addSingleOrder(event.orderId, event.singleProduct!, event.totalAmount);
        emit(AddOrdersLoadedState());
      }
    });
    //Used to Load the initial widget
    on<OrderLoadingEvents>((event, emit) => null);
    on<PaymentMethodEvent>((event, emit) => emit(PaymentMethodState()));
    on<OrderScreenEvent>((event, emit) => emit(OrderScreenState()));
    on<BillingScreenEvent>((event, emit) => emit(BillingScreenState()));
    //Used for page Navigation
     on<PaymentMethodNavigationEvent>((event, emit) => emit(PaymentMethodNavigationState()));
     on<OrderScreenNavigationEvent>((event, emit) => emit(OrderScreenNavigationState()));
     on<BillingScreenNavigationEvent>((event, emit) => emit(BillingScreenNavigationState()));

  }

}