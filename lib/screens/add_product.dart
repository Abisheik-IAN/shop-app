import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc/product_bloc.dart';
import '../bloc/product_bloc/product_events.dart';
import '../bloc/product_bloc/product_state.dart';
import '../bloc/product_bloc/recent_product_bloc.dart';
import '../utils/dynamicheigthwidth.dart';
import '../widgets/alert_dialog.dart';




class AddNewProduct extends StatefulWidget {
  const AddNewProduct({Key? key}) : super(key: key);

  @override
  _AddNewProductState createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  TextEditingController name =  TextEditingController();
  TextEditingController offerPrice =  TextEditingController();
  TextEditingController price =  TextEditingController();
  TextEditingController productImg =  TextEditingController();

  @override
  void initState() {
    super.initState();
    // context.read<ProductBloc>().add(AddProductWidgetEvent());


  }
  final _formKey = GlobalKey<FormState>();
  Widget AddProducts(AddProductWidgetState state){
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [

            SizedBox(height: getDeviceheight(context, 0.02),),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              decoration: inputDecoration("Product Name",state.name,"Name Required!"),
              controller: name,
            ),
             SizedBox(
              height: getDeviceheight(context, 0.029),
            ),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              decoration: inputDecoration("Offer Price",state.offerprice,"Offer Price Required!"),
              controller: offerPrice,
            ),
            SizedBox(
              height: getDeviceheight(context, 0.029),
            ),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              decoration: inputDecoration("Price",state.price,"Price Required!"),
              controller: price,
            ),
            SizedBox(
              height: getDeviceheight(context, 0.029),
            ),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              decoration: inputDecoration("Product Image Url",state.imageurl,"Image Url Required!"),
              controller: productImg,
            ),
            SizedBox(
              height: getDeviceheight(context, 0.029),
            ),
            RaisedButton(
                color: Colors.blue,
                onPressed:
                    (){
                  print("inside on pressed");

                  _formKey.currentState!.save();
                  context.read<ProductBloc>().add(FieldValidationErrorEvent(name: name.text,offerprice: offerPrice.text , price: price.text, imageurl: productImg.text ));

                  },

                child: const Text("Save",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add New Product"),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
          context.read<ProductBloc>().add(LoadProductEvents());
          context.read<RecentProductBloc>().add(LoadRecentProductEvents());
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const HomePage()));
          }, icon: Icon(Icons.arrow_back),),
      ),
      body: BlocListener<ProductBloc,ProductState>(
        listener: (context, state) {
          if (state is AddProductWidgetState){
            AddProducts(state);
          }
          if(state is FieldValidationSuccessState){
            context.read<ProductBloc>().add(UpdateAddProductEvent(name: name.text, offerprice: int. parse(offerPrice.text) , price: int.parse(price.text), productImg: productImg.text, timeStamp: FieldValue.serverTimestamp().toString()));///Add product event is triggered here...
          }

        },
      child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is AddProductWidgetState) {

        return  AddProducts(state);
      }
      if(state is AddProductLoadingState){
        return Container(height:getDeviceheight(context, 1),width:getDevicewidth(context, 1),child:Center(child:CircularProgressIndicator() ,) );
      }
      if (state is AddProductLoadedState) {
        return AlertComponent(title: "Success State",message: "Product add successfully",onpress: (){
          Navigator.of(context).pop();
          context.read<ProductBloc>().add(LoadProductEvents());
          context.read<RecentProductBloc>().add(LoadRecentProductEvents());
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  HomePage()));
        }).AlertBox();

      }
      if(state is PriceDiffError){
        return AlertComponent(title: "Error",message: "Offer Price should be less than Price,Plz Check it!!",onpress: (){context.read<ProductBloc>().add(AddProductWidgetEvent());}).AlertBox();
      }

      else {
        return
          AlertComponent(title: "Error State", message: "Something Went Wrong", onpress: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
          context.read<ProductBloc>().add(LoadProductEvents());
          context.read<RecentProductBloc>().add(LoadRecentProductEvents());
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const HomePage()));
        }).AlertBox();

      }
    }),),

      );
    // );
  }

  InputDecoration inputDecoration(String labelText,bool error,String errortext) {
    return InputDecoration(
      focusColor: Colors.blue,
      labelStyle: const TextStyle(color: Colors.grey),
      labelText: labelText,
      fillColor: Colors.white,
      errorText: (!error)?errortext:null,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: Colors.red),
      ),
      errorStyle: const TextStyle(color: Colors.red),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 2.0,
        ),
      ),
    );
  }
}
