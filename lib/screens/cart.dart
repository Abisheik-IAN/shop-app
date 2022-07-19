import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/cart_bloc/cart_events.dart';
import '../bloc/cart_bloc/cart_state.dart';
import '../bloc/cart_bloc/cartcount_bloc.dart';
import '../bloc/order_bloc/order_bloc.dart';
import '../bloc/order_bloc/order_events.dart';
import '../utils/dynamicheigthwidth.dart';
import 'order_screen.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  List productsName = [];
  List productOfferPrice = [];
  List productPrice = [];
  List productId=[];
  List productImage=[];
  List quantity=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("triggered");
    context.read<CartBloc>().add(LoadCartEvents());
    context.read<CartCountBloc>().add(CartCountIncrementEvent());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My cart"),
          centerTitle: true,
        ),
        body: BlocListener<CartBloc, CartState>(
          listener: (context, state) {
            if (state is CartDeleteItemLoadedState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Product deleted Successfully")));
              context.read<CartBloc>().add(LoadCartEvents());
            }
          },
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoadingState) {
                return SizedBox(
                    width: getDevicewidth(context, 1),
                    height: getDeviceheight(context, 1),
                    child: const Center(child: CircularProgressIndicator()));
              }
              if (state is CartLoadedState) {
                int i;
                if(productImage.length <= state.product.length){
                for( i=0;i<state.product.length;i++){
                  productsName.add(state.product[i].name);
                  productId.add(state.product[i].id);
                  productImage.add(state.product[i].productImg);
                  productOfferPrice.add(state.product[i].offerPrice);
                  productPrice.add(state.product[i].price);
                  quantity.add(state.product[i].quantity);
                }}
                print("length"+productImage.length.toString()+" "+state.product.length.toString());
                return Card(
                  semanticContainer: true,
                  margin: const EdgeInsets.all(2),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: ListView.builder(
                    itemCount: state.product.length,
                    itemBuilder: (BuildContext context, int index) {
                      productsName.add(state.product[index].name);
                      productId.add(state.product[index].id);
                      productImage.add(state.product[index].productImg);
                      productOfferPrice.add(state.product[index].offerPrice);
                      productPrice.add(state.product[index].price);
                      quantity.add(state.product[index].quantity);
                      int _itemCount = state.product[index].quantity!;
                      return Card(
                        semanticContainer: true,
                        margin: const EdgeInsets.all(2),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image(
                              image: NetworkImage(
                                  state.product[index].productImg!),
                              width: getDevicewidth(context, 0.20),
                              height: getDeviceheight(context, 0.15),
                              fit: BoxFit.cover,
                            ),

                            Container(
                              padding: EdgeInsets.only(left:getDevicewidth(context, 0.08)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: getDeviceheight(context, 0.01),
                                  ),
                                  Text(state.product[index].name!),
                                  SizedBox(
                                    height: getDeviceheight(context, 0.01),
                                  ),
                                  Text(
                                      "Price: " +
                                          state.product[index].price.toString(),
                                      style: const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough)),
                                  SizedBox(
                                    height: getDeviceheight(context, 0.01),
                                  ),
                                  Text("Offer Price: " +
                                      state.product[index].offerPrice.toString()),
                                  Row(
                                    children: [
                                      Text("Quantity : "),
                                      state.product[index].quantity != 1
                                          ?  IconButton(
                                              icon:  Icon(Icons.remove),
                                              onPressed: (){
                                                context.read<CartBloc>().add(
                                                    DecreamentCartEvent(
                                                        id: state.product[index].id!,
                                                        ));
                                                context
                                                    .read<CartBloc>()
                                                    .add(LoadCartEvents());
                                              },
                                            )
                                          :  Container(),
                                       Text(_itemCount.toString()),
                                       IconButton(
                                          icon:  Icon(Icons.add),
                                          onPressed: () {
                                            context.read<CartBloc>().add(
                                                UpdateAddCartEvent(
                                                    id: state.product[index].id!,
                                                    name: state
                                                        .product[index].name!,
                                                    offerprice: state
                                                        .product[index]
                                                        .offerPrice!,
                                                    price: state
                                                        .product[index].price!,
                                                    productImg: state
                                                        .product[index]
                                                        .productImg!));
                                            context
                                                .read<CartBloc>()
                                                .add(LoadCartEvents());
                                          })
                                    ],
                                  )
                                ],
                              ),
                            ),
                            //
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  context.read<CartBloc>().add(
                                      CartDeletetLoadedEvent(
                                          id: state.product[index].id!));
                                  context
                                      .read<CartCountBloc>()
                                      .add(CartCountIncrementEvent());
                                },
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                  size: 30,
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Text("Something went wrong");
              }
            },
          ),
        ),
    floatingActionButton: FloatingActionButton.extended(
        elevation: 0.0,
        // child: Row(children: [Text("Checkout"),Icon(Icons.check)],) ,
        backgroundColor: new Color(0xFFE57373),
         label: Row(children: [Text("CheckOut"),SizedBox(width: 10,),Icon(Icons.check_circle)],),
      onPressed: (){
        context.read<CartBloc>().add(NavigatetoOrderEvent(isCart: true, context: context));
        context.read<OrderBloc>().add(OrderScreenEvent());
      },
    ),);
  }
}
