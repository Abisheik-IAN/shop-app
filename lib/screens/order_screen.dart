
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp_multiplatform/bloc/order_bloc/order_bloc.dart';
import 'package:shopapp_multiplatform/bloc/order_bloc/order_events.dart';
import 'package:shopapp_multiplatform/model/order_model.dart';
import 'package:shopapp_multiplatform/model/product_model.dart';
import 'package:shopapp_multiplatform/screens/billing_screen.dart';
import 'package:shopapp_multiplatform/utils/dynamicheigthwidth.dart';

import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/cart_bloc/cart_events.dart';
import '../bloc/order_bloc/order_state.dart';
import '../model/cart_model.dart';

class OrderScreen extends StatefulWidget {
  final int orderid;
  final bool iscart;
  final bool isorder;
  final List<Products>? orderAgainProducts;
  final List<CartModel>? products;
  final ProductModel? singleProduct;
  final int totalAmount;
  final int totalOfferAmount;
  const OrderScreen({
    Key? key,
    required this.orderid,
    required this.iscart,
    required this.isorder,
    this.orderAgainProducts,
    this.products,
    this.singleProduct,
    required this.totalAmount,
    required this.totalOfferAmount

  }) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}
int totalAmount=0;
class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    int sec = DateTime.now().millisecondsSinceEpoch;
    print(sec);
    return Scaffold(
      appBar: AppBar(title: Text("Checkout Screen"),),
      body: SingleChildScrollView(
        child:BlocListener<OrderBloc,OrderState>(
          listener: (context,state) {
            if(state is BillingScreenNavigationState){
              widget.isorder?Navigator.push(context, MaterialPageRoute(builder: (context)=>BillinScreen(orderid: widget.orderid,iscart: widget.iscart,isorder:widget.isorder,orderAgainProducts: widget.orderAgainProducts,totalAmount: widget.totalAmount,totalOfferAmount: widget.totalOfferAmount,))):
              widget.iscart?Navigator.push(context, MaterialPageRoute(builder: (context)=>BillinScreen(orderid: widget.orderid,iscart: widget.iscart,isorder: widget.isorder,products: widget.products,totalAmount: widget.totalAmount,totalOfferAmount: widget.totalOfferAmount,))):
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BillinScreen(orderid: widget.orderid,iscart: widget.iscart,isorder: widget.isorder,singleProduct: widget.singleProduct,totalAmount: widget.totalAmount,totalOfferAmount: widget.totalOfferAmount,)));
              context.read<OrderBloc>().add(BillingScreenEvent());
            }
          },
          child: BlocBuilder<OrderBloc,OrderState>(
            builder: (context, state) {
              if(state is OrderScreenState){
                return Column(
                  children: [
                    // Container(
                    //   height: getDeviceheight(context, 0.08),
                    //   padding: EdgeInsets.all(8),
                    //   child: Card(
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.end,
                    //       children: [
                    //         // Text("Order Id: "+widget.orderid.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                    //       ],
                    //     ),
                    //   )
                    //
                    // ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: ListView.builder(
                          itemCount:widget.isorder?widget.orderAgainProducts!.length:widget.iscart?widget.products!.length:1,
                          shrinkWrap: true,
                          itemBuilder: (contex,index){
                            return SizedBox(
                              // height: getDeviceheight(context, 0.17),
                              child: Card(
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: getDevicewidth(context, 0.05),),
                                      SizedBox(
                                        width:getDevicewidth(context, 0.20),
                                        child: Container(
                                          height: getDeviceheight(context, 0.20),
                                          width: getDevicewidth(context, 0.20),

                                          child: Image.network(widget.isorder?widget.orderAgainProducts![index].productImg!:widget.iscart?widget.products![index].productImg!:widget.singleProduct!.productImg!,fit: BoxFit.cover,),
                                        ),
                                      ),
                                      SizedBox(width: getDevicewidth(context, 0.1),),

                                      SizedBox(
                                        width:getDevicewidth(context, 0.4),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            widget.isorder?Text(widget.orderAgainProducts![index].name!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),):widget.iscart?Text(widget.products![index].name!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),):Text(widget.singleProduct!.name!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                            SizedBox(height: getDevicewidth(context, 0.03),),
                                            Row(
                                              children: [
                                                widget.isorder?Text("₹ "+widget.orderAgainProducts![index].price.toString(),style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 18,fontWeight: FontWeight.bold,color: Colors.red),):widget.iscart?Text("₹ "+widget.products![index].price.toString(),style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 18,fontWeight: FontWeight.bold,color: Colors.red),):Text("₹ "+widget.singleProduct!.price.toString(),style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 18,fontWeight: FontWeight.bold,color: Colors.red)),
                                                SizedBox(width: getDevicewidth(context, 0.05),),
                                                widget.isorder?Text("₹ "+widget.orderAgainProducts![index].offerPrice.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green)):widget.iscart?Text("₹ "+widget.products![index].offerPrice.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green)):Text("₹ "+widget.singleProduct!.offerPrice.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green)),

                                              ],),
                                            SizedBox(height: getDevicewidth(context, 0.03),),
                                            widget.isorder?Text("Items: "+widget.orderAgainProducts![index].quantity.toString(),style: TextStyle(fontSize: 18,)):widget.iscart?Text("Items: "+widget.products![index].quantity.toString(),style: TextStyle(fontSize: 18,)):Text("Items: 1",style: TextStyle(fontSize: 18)),
                                          ],
                                        ),
                                      ),
                                    ],),
                                ),
                              ),
                            );
                          }),
                    ),

                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(children: [Spacer(),Text("You Saved: "+widget.totalOfferAmount.toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.green))],),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(children: [Spacer(),Text("Total Amount: "+widget.totalAmount.toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15))
                      ],),
                    ),

                  ],
                );
              }else{
                return Text("Something Went Wrong");
              }
            },
          ),
        )
        ,
      ),
      floatingActionButton:  FloatingActionButton.extended(
      elevation: 0.0,
      // child: Row(children: [Text("Checkout"),Icon(Icons.check)],) ,
      backgroundColor: new Color(0xFFE57373),
      label: Row(children: [Text("Billing"),SizedBox(width: 10,),Icon(Icons.check_circle)],),
      onPressed: (){
        context.read<OrderBloc>().add(BillingScreenNavigationEvent());
        },
    ),
    );

  }
}
