
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../repository/cart_repo/cart_repo.dart';
import 'cart_events.dart';
import 'cart_state.dart';

class CartCountBloc extends Bloc<CartEvents, CartState> {
  final CartRepo _cartRepo;

  CartCountBloc({required CartRepo cartRepo})
      : _cartRepo = cartRepo,
        super(CartCountLoadingState()) {
    on<CartEvents>((event, emit) async {
      if(event is CartCountLoadingEvent || event is CartCountIncrementEvent){
      final product = await _cartRepo.getAllCartItems();
      print("bacth"+product.length.toString());
      emit(CartCountIncrementState(CartCount: product.length.toString()));}
    });

  }
}