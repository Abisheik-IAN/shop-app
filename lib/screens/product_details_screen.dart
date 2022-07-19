import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp_multiplatform/bloc/order_bloc/order_events.dart';
import 'package:shopapp_multiplatform/bloc/order_bloc/order_state.dart';

import 'package:shopapp_multiplatform/screens/order_screen.dart';
import 'package:shopapp_multiplatform/utils/dynamicheigthwidth.dart';
import 'package:readmore/readmore.dart';

import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/cart_bloc/cart_events.dart';
import '../bloc/order_bloc/order_bloc.dart';
import '../model/cart_model.dart';

class ProductDetails extends StatefulWidget {
  final String id;
  final String product_img;
  final String product_name;
  final int product_price;
  final int product_offerprice;
  final String product_description;
  const ProductDetails(
      {Key? key,
        required this.id,
      required this.product_img,
      required this.product_name,
      required this.product_price,
      required this.product_offerprice,
      required this.product_description})
      : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product_name),
      ),
      body: SingleChildScrollView(
        child: getDevicewidth(context, 1)<1024?Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
                width: getDevicewidth(context, 1),
                height: getDeviceheight(context, 0.45),
                fit: BoxFit.cover,
                image: NetworkImage(
                  widget.product_img,
                )),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                widget.product_name,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Text("MRP Price: "+
                widget.product_price.toString(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    decoration: TextDecoration.lineThrough,decorationColor: Colors.red),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Text("Deal Price: "+
                widget.product_offerprice.toString(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Text("You Saved: "+
                  (widget.product_price-widget.product_offerprice).toString(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: getDevicewidth(context, 0.45),
                  height: getDeviceheight(context, 0.06),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.orangeAccent)))),
                    onPressed: () {
                      context.read<CartBloc>().add(NavigatetoOrderEvent(isCart: false, context: context,productId: widget.id));
                      context.read<OrderBloc>().add(OrderScreenEvent());
                    },
                    child: Text("Buynow"),
                  ),
                ),
                Container(
                  width: getDevicewidth(context, 0.45),
                  height: getDeviceheight(context, 0.06),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.yellow[900]),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.yellow)))),
                    onPressed: () {
                      context.read<CartBloc>().add(UpdateAddCartEvent(id:widget.id,name: widget.product_name,offerprice: widget.product_offerprice,price: widget.product_price,productImg: widget.product_img));
                      context.read<CartBloc>().add(LoadCartEvents());
                    },
                    child: Text("Add to cart"),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Product Description:",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ReadMoreText(
                widget.product_description,
                trimLines: 2,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: '...View more',
                trimExpandedText: 'View less',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
                moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.blue),
                lessStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.blue),
              ),
            ),

          ],
        ):
        Container(
          padding: EdgeInsets.fromLTRB(getDevicewidth(context, 0.05), 0, getDevicewidth(context, 0.05), 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                  width: getDevicewidth(context, 0.7),
                  height: getDeviceheight(context, 0.7),
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.product_img,
                  )),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  widget.product_name,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text("MRP Price: "+
                    widget.product_price.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      decoration: TextDecoration.lineThrough,decorationColor: Colors.red),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text("Deal Price: "+
                    widget.product_offerprice.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text("You Saved: "+
                    (widget.product_price-widget.product_offerprice).toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: getDevicewidth(context, 0.45),
                    height: getDeviceheight(context, 0.08),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.orangeAccent)))),
                      onPressed: () {
                        context.read<CartBloc>().add(NavigatetoOrderEvent(isCart: false, context: context,productId: widget.id));                      },
                      child: Text("Buynow"),
                    ),
                  ),
                  Container(
                    width: getDevicewidth(context, 0.45),
                    height: getDeviceheight(context, 0.08),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.yellow[900]),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.yellow)))),
                      onPressed: () {
                        context.read<CartBloc>().add(UpdateAddCartEvent(id:widget.id,name: widget.product_name,offerprice: widget.product_offerprice,price: widget.product_price,productImg: widget.product_img));
                        context.read<CartBloc>().add(LoadCartEvents());
                      },
                      child: Text("Add to cart"),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Product Description:",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: ReadMoreText(
                  widget.product_description,
                  trimLines: 2,
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '...View more',
                  trimExpandedText: 'View less',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                  moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.blue),
                  lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.blue),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
