import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp_multiplatform/bloc/order_bloc/order_bloc.dart';
import 'package:shopapp_multiplatform/bloc/order_bloc/order_events.dart';
import 'package:shopapp_multiplatform/screens/home_page.dart';
import 'package:shopapp_multiplatform/utils/dynamicheigthwidth.dart';

import '../bloc/order_bloc/order_state.dart';
import '../model/cart_model.dart';
import '../model/order_model.dart';
import '../model/product_model.dart';

class PaymentMethodScreen extends StatefulWidget {
  final int orderid;
  final bool iscart;
  final bool isorder;
  final List<Products>? orderAgainProducts;
  final List<CartModel>? products;
  final ProductModel? singleProduct;
  final int totalAmount;
  final int totalOfferAmount;
  const PaymentMethodScreen({
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
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  TextEditingController  upiController=  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Method"),
      ),
      body: SingleChildScrollView(

        child: BlocListener<OrderBloc,OrderState>(
          listener: (context,state) {
            if(state is AddOrdersLoadedState){
              showAlertDialog(context);
            }
          },
          child: BlocBuilder<OrderBloc,OrderState>(
            builder: (context, state) {
              if(state is PaymentMethodState){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Payment Method",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black)),
                    ExpansionTile(
                      title: Text('UPI'),
                      subtitle: Text('PhonePe,Google pay,Amazon Pay any UPI apps'),
                      children: <Widget>[
                        TextFormField(
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required field!';
                              }
                              return null;
                            },
                            controller: upiController,
                            decoration: inputDecoration("Your UPI ID")
                        ),
                        ElevatedButton(onPressed: (){}, child: Text("Pay"))
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Wallets'),
                      subtitle: Text('PayTm'),
                      children: <Widget>[
                        TextFormField(
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required field!';
                              }
                              return null;
                            },
                            controller: upiController,
                            decoration: inputDecoration("Enter the paytm linked number")
                        ),
                        ElevatedButton(onPressed: (){}, child: Text("Pay"))
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Credit/ Debit/ ATM Card'),
                      subtitle: Text('Card Payments'),
                      children: <Widget>[
                        TextFormField(
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required field!';
                              }
                              return null;
                            },
                            controller: upiController,
                            decoration: inputDecoration("Card Number")
                        ),
                        TextFormField(
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required field!';
                              }
                              return null;
                            },
                            controller: upiController,
                            decoration: inputDecoration("valid thru")
                        ),
                        TextFormField(
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required field!';
                              }
                              return null;
                            },
                            controller: upiController,
                            decoration: inputDecoration("CVV")
                        ),

                        ElevatedButton(onPressed: (){}, child: Text("Pay"))
                      ],
                    ),
                  ],
                );
              }else{
                return Text("Something Went Wrong");
              }
            },
          ),
        ),


      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0.0,
        // child: Row(children: [Text("Checkout"),Icon(Icons.check)],) ,
        backgroundColor: new Color(0xFFE57373),
        label: Row(children: [Text("Place Order"),SizedBox(width: 10,),Icon(Icons.check_circle)],),
        onPressed: (){
          widget.iscart?context.read<OrderBloc>().add(AddOrdersEvent(orderId: widget.orderid, isCart: widget.iscart, totalAmount: widget.totalAmount,cartProducts: widget.products)):
          context.read<OrderBloc>().add(AddOrdersEvent(orderId: widget.orderid, isCart: widget.iscart, totalAmount: widget.totalAmount,singleProduct: widget.singleProduct));

        },
      ),
    );
  }
  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      focusColor: Colors.white,
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
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage()
            ),
            ModalRoute.withName("/home")
        );
        // Navigator.of(context).popUntil((route) => );
        // context.read<ProductBloc>().add(LoadProductEvents());
        // context.read<RecentProductBloc>().add(LoadRecentProductEvents());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Success"),
      content: Text("Your Order placed Successfully"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
