
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc/cart_state.dart';
import '../bloc/cart_bloc/cartcount_bloc.dart';

class NamedIcon extends StatelessWidget {
  final Color? iconcolor;
  const NamedIcon({
    Key? key,
     this.iconcolor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String count="";
    return BlocListener<CartCountBloc, CartState>(
      listener: (context, state) {
        if(state is CartCountIncrementState){
          count=state.CartCount;
        }
      },
      child: BlocBuilder<CartCountBloc,CartState>(
        builder:(context, state) {
          print(state);
          if(state is CartCountIncrementState){
            print(state.CartCount);
            return Badge(
                position: BadgePosition.topEnd(top: -14, end: 0),
                badgeContent: Text(state.CartCount),
                child: Icon(Icons.shopping_cart_outlined,color: iconcolor,)
            );
          }else{
            return Container();
          }
        },

      ),
    );
  }
}