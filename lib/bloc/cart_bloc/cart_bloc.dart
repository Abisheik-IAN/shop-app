
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp_multiplatform/bloc/order_bloc/order_state.dart';

import '../../model/product_model.dart';
import '../../repository/cart_repo/cart_repo.dart';
import '../../screens/order_screen.dart';
import 'cart_events.dart';
import 'cart_state.dart';



class CartBloc extends Bloc<CartEvents, CartState> {
  final CartRepo _cartRepo;

  CartBloc({required CartRepo cartRepo})
      : _cartRepo = cartRepo,
        super(CartLoadingState()) {
    on<LoadCartEvents>((event, emit) async {
      // print("inside cart loading");
      emit(CartLoadingState());
      final product = await _cartRepo.getAllCartItems();///It get all the product details(name,price,offer_price,Image) from firestore..

      // print("Mycart length" + product.length.toString());
      emit(CartLoadedState(product: product));
    });
    on<UpdateAddCartEvent>((event, emit)async{
      emit(AddToCartLoadingState());
      // print("inside events"+event.name);
      ProductModel(name: event.name,offerPrice: event.offerprice,price: event.price,productImg: event.productImg);
      // print(ProductModel().toJson());
      await _cartRepo.addCartItem(event.id,event.name,event.offerprice,event.price,event.productImg);///The value of new products(name,price,offer_price,Image) send to firestore..
      emit(AddToCartLoadedState());
      emit(CartLoadingState());
      final product = await _cartRepo.getAllCartItems();///It get all the product details(name,price,offer_price,Image) from firestore..

      // print("Mycart length" + product.length.toString());
      emit(CartLoadedState(product: product));

    });
    on<DecreamentCartEvent>((event, emit)async {
      emit(AddToCartLoadingState());
      // print("inside events"+event.name);
      // ProductModel(name: event.name,offerPrice: event.offerprice,price: event.price,productImg: event.productImg);
      // print(ProductModel().toJson());
      await _cartRepo.decreaseCartItem(event.id);///The value of new products(name,price,offer_price,Image) send to firestore..
      // emit(AddToCartLoadedState());
      emit(CartLoadingState());
      final product = await _cartRepo.getAllCartItems();///It get all the product details(name,price,offer_price,Image) from firestore..

      // print("Mycart length" + product.length.toString());
      emit(CartLoadedState(product: product));
    });
    on<CartDeletetLoadedEvent>((event, emit) async {
      emit(CartDeleteItemLoadingState());
      await _cartRepo.deleteCartItem(event.id);

      emit(CartDeleteItemLoadedState());
    });
    on<NavigatetoOrderEvent>((event, emit) async {
      int totalamount=0;
      int totaloffer=0;
      if(event.isCart){
        final product = await _cartRepo.getAllCartItems();
        for(int i=0;i<product.length;i++){
          var singleProduct=0;
          var offer = 0;

          singleProduct = product[i].offerPrice! * product[i].quantity!;
          offer = (product[i].price!-product[i].offerPrice!)*product[i].quantity!;
          totaloffer=totaloffer+offer;
          totalamount = totalamount+singleProduct;
        }
        Navigator.push(event.context, MaterialPageRoute(builder: (context) => OrderScreen(orderid: DateTime.now().millisecondsSinceEpoch,iscart:event.isCart,products: product,totalAmount: totalamount,totalOfferAmount: totaloffer, isorder: false,)));
      }else{
        final product = await _cartRepo.getSingleProduct(event.productId!);
        var singleProduct=0;
        var offer = 0;
        singleProduct = product.offerPrice! * 1;
        offer = (product.price!-product.offerPrice!)*1;
        totaloffer=totaloffer+offer;
        totalamount = totalamount+singleProduct;
        Navigator.push(event.context, MaterialPageRoute(builder: (context) => OrderScreen(orderid: DateTime.now().millisecondsSinceEpoch,iscart:event.isCart,singleProduct: product,totalAmount: totalamount,totalOfferAmount: totaloffer,isorder: false,)));
      }
    });

  }
}