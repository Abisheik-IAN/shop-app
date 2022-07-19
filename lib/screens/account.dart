
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp_multiplatform/bloc/order_bloc/order_bloc.dart';
import 'package:shopapp_multiplatform/bloc/order_bloc/order_events.dart';
import 'package:shopapp_multiplatform/screens/my_order_screen.dart';
import 'package:shopapp_multiplatform/utils/dynamicheigthwidth.dart';

import '../bloc/cart_bloc/cart_events.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Account"),),
      body:SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getDeviceheight(context, 0.1),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrderScreen()));
                  context.read<OrderBloc>().add(LoadOrderEvents());
                },
                child: Card(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: getDevicewidth(context, 0.03),),
                      Icon(Icons.shopping_basket_outlined,size: 25,color: Colors.blueAccent,),
                      SizedBox(width: getDevicewidth(context, 0.07),),
                      Text("Your Orders",style: TextStyle(fontSize: 19),)
                    ],),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
