
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp_multiplatform/bloc/order_bloc/order_events.dart';
import 'package:shopapp_multiplatform/screens/payment_method_screen.dart';
import 'package:shopapp_multiplatform/utils/dynamicheigthwidth.dart';

import '../bloc/order_bloc/order_bloc.dart';
import '../bloc/order_bloc/order_state.dart';
import '../model/cart_model.dart';
import '../model/order_model.dart';
import '../model/product_model.dart';

class BillinScreen extends StatefulWidget {
  final int orderid;
  final bool iscart;
  final bool isorder;
  final List<Products>? orderAgainProducts;
  final List<CartModel>? products;
  final ProductModel? singleProduct;
  final int totalAmount;
  final int totalOfferAmount;
  const BillinScreen({
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
  _BillinScreenState createState() => _BillinScreenState();
}

class _BillinScreenState extends State<BillinScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController  doornoController=  TextEditingController();
  TextEditingController streetController =  TextEditingController();
  TextEditingController areaController =  TextEditingController();
  TextEditingController cityController =  TextEditingController();
  TextEditingController stateController =  TextEditingController();
  TextEditingController pincodeController =  TextEditingController();
  TextEditingController phoneController =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delivery Address",),),
      body: SingleChildScrollView(
        child: BlocListener<OrderBloc,OrderState>(
          listener: (context,state) {
            if(state is PaymentMethodNavigationState){
              context.read<OrderBloc>().add(PaymentMethodEvent());
              widget.isorder?Navigator.push(context, MaterialPageRoute(builder: (context)=>BillinScreen(orderid: widget.orderid,iscart: widget.iscart,isorder:widget.isorder,orderAgainProducts: widget.orderAgainProducts,totalAmount: widget.totalAmount,totalOfferAmount: widget.totalOfferAmount,))):
              widget.iscart?Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentMethodScreen(orderid: widget.orderid,iscart: widget.iscart,isorder: widget.isorder,products: widget.products,totalAmount: widget.totalAmount,totalOfferAmount: widget.totalOfferAmount,))):
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentMethodScreen(orderid: widget.orderid,iscart: widget.iscart,isorder: widget.isorder,singleProduct: widget.singleProduct,totalAmount: widget.totalAmount,totalOfferAmount: widget.totalOfferAmount,)));
            }
          },
          child: BlocBuilder<OrderBloc,OrderState>(
            builder: (context, state) {
              if(state is BillingScreenState){
                return SizedBox(
                  height: getDeviceheight(context, 0.6),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Delivery Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black)),
                        SizedBox(
                          width: getDevicewidth(context, 0.9),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: inputDecoration("Building/Flat/Door No"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required field!';
                              }
                              return null;
                            },
                            controller: doornoController,
                          ),
                        ),
                        SizedBox(
                          width: getDevicewidth(context, 0.9),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: inputDecoration("Street"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required field!';
                              }
                              return null;
                            },
                            controller: streetController,
                          ),
                        ),
                        SizedBox(
                          width: getDevicewidth(context, 0.9),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: inputDecoration("Area/Thaluk"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required field!';
                              }
                              return null;
                            },
                            controller: areaController,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: getDevicewidth(context, 0.45),
                              child: TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: inputDecoration("city"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required field!';
                                  }
                                  return null;
                                },
                                controller: cityController,
                              ),
                            ),
                            SizedBox(
                              width: getDevicewidth(context, 0.45),
                              child: TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: inputDecoration("State"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required field!';
                                  }
                                  return null;
                                },
                                controller: stateController,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: getDevicewidth(context, 0.45),
                              child: TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: inputDecoration("pincode"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required field!';
                                  }
                                  return null;
                                },
                                controller: pincodeController,
                              ),
                            ),
                            SizedBox(
                              width: getDevicewidth(context, 0.45),
                              child: TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: inputDecoration("phone number"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required field!';
                                  }
                                  return null;
                                },
                                controller: phoneController,
                              ),
                            )
                          ],
                        )

                      ],
                    ),
                  ),
                );
              }else{
                return Text("Something Went Wrong");
              }
            },
          ),
        )
        ,
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0.0,
        // child: Row(children: [Text("Checkout"),Icon(Icons.check)],) ,
        backgroundColor: new Color(0xFFE57373),
        label: Row(children: [Text("Payment Method"),SizedBox(width: 10,),Icon(Icons.check_circle)],),
        onPressed: (){
          if(_formKey.currentState!.validate()) {
            context.read<OrderBloc>().add(PaymentMethodNavigationEvent());
          }
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentMethodScreen()));

        },
      ),
    );
  }
  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      focusColor: Colors.blueAccent,
      labelStyle: TextStyle(color: Colors.grey),
      labelText: labelText,
      // errorText: "Required field!",
      errorStyle: TextStyle(color: Colors.red),
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(color: Colors.blueAccent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 2.0,
        ),
      ),
    );
  }
}
