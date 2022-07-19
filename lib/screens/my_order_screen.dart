
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/cart_bloc/cart_events.dart';
import '../bloc/order_bloc/order_bloc.dart';
import '../bloc/order_bloc/order_events.dart';
import '../bloc/order_bloc/order_state.dart';
import '../utils/dynamicheigthwidth.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Orders"),),
      body: SingleChildScrollView(
        child: BlocBuilder<OrderBloc,OrderState>(
          builder: (context, state) {
            if(state is OrderLoadingState){
              return CircularProgressIndicator();
            }
            if(state is OrderLoadedState){
              return Column(
                children: [
                  SizedBox(
                    // height: getDeviceheight(context, 1),
                    child: ListView.builder(
                        shrinkWrap: true,
                      itemCount: state.order.length,
                        itemBuilder: (context, index) {
                      var date = state.order[index].timestamp!.toDate().day;
                      var mon = state.order[index].timestamp!.toDate().month;
                      var yr =state.order[index].timestamp!.toDate().year;
                      // state.order[index].products[index].
                      return Card(
                        child: ExpansionTile(
                          title: Row(
                            children: [
                              // SizedBox(
                              //   width: getDevicewidth(context, 0.3),
                              //   child: Container(
                              //     height: getDeviceheight(context, 0.08),
                              //     width: getDevicewidth(context, 0.08),
                              //
                              //     child: Image.network("https://images.news18.com/ibnlive/uploads/2022/01/iqoo-9-pro.jpg",fit: BoxFit.cover,),
                              //   ),
                              // ),
                              Expanded(
                                // width: getDevicewidth(context, 0.35),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[

                                      Text("Order id: "+state.order[index].orderId.toString()),
                                      SizedBox(height: getDeviceheight(context, 0.02),),
                                      Text("Price: "+state.order[index].totalAmount.toString()),
                                      // Text('Delivered at 27-May-2022',style: TextStyle(color: Colors.green)),

                                    ] ),
                              ),
                              Container(height: getDeviceheight(context, 0.07),width: getDevicewidth(context, 0.005),color: Colors.grey[300],),
                              SizedBox(width: getDevicewidth(context, 0.05),),
                              Expanded(
                                // width: getDevicewidth(context, 0.4),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[

                                      Text("Products: "+state.order[index].products!.length.toString()),
                                      SizedBox(height: getDeviceheight(context, 0.02),),
                                      Text("Order Date : "+date.toString()+"-"+mon.toString()+"-"+yr.toString()),


                                    ] ),
                              )
                            ],
                          ),
                          // subtitle: Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     Text('Delivered at 27-May-2022',style: TextStyle(color: Colors.green,fontSize: 16)),
                          //   ],
                          // ),
                          children: <Widget>[
                            SizedBox(
                              // height: getDeviceheight(context, 0.5),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                itemCount: state.order[index].products!.length,
                                  itemBuilder: (context,indec){
                                return Card(
                                  elevation: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: getDevicewidth(context, 0.1),),
                                        SizedBox(
                                          width:getDevicewidth(context, 0.12),
                                          child: Container(
                                            height: getDeviceheight(context, 0.12),
                                            width: getDevicewidth(context, 0.12),

                                            child: Image.network(state.order[index].products![indec].productImg!,fit: BoxFit.cover,),
                                          ),
                                        ),
                                        SizedBox(width: getDevicewidth(context, 0.2),),

                                        SizedBox(
                                          width:getDevicewidth(context, 0.4),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(state.order[index].products![indec].name!,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                              SizedBox(height: getDevicewidth(context, 0.03),),
                                              Row(
                                                children: [
                                                  Text("₹ "+state.order[index].products![indec].price.toString(),style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 16,fontWeight: FontWeight.bold,color: Colors.red),),
                                                  SizedBox(width: getDevicewidth(context, 0.05),),
                                                  Text("₹ "+state.order[index].products![indec].offerPrice.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.green)),

                                                ],),
                                              SizedBox(height: getDevicewidth(context, 0.03),),
                                              Text("Items: "+state.order[index].products![indec].quantity.toString(),style: TextStyle(fontSize: 18,)),
                                            ],
                                          ),
                                        ),
                                      ],),
                                  ),
                                );
                              }),
                            ),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(padding: EdgeInsets.only(left: getDevicewidth(context, 0.03),right: getDevicewidth(context, 0.03)),width: getDevicewidth(context, 1),height: getDeviceheight(context, 0.003),child:Container(color: Colors.grey[300]),),
                                Container(
                                padding: EdgeInsets.only(left: getDevicewidth(context, 0.03),right: getDevicewidth(context, 0.03)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                  TextButton(onPressed: (){}, child: Text("Buy it Again")),
                                      Icon(Icons.arrow_forward_ios,size: 16,color: Colors.blueAccent,)
                                  ]),
                                ),
                                Container(padding: EdgeInsets.only(left: getDevicewidth(context, 0.03),right: getDevicewidth(context, 0.03)),width: getDevicewidth(context, 1),height: getDeviceheight(context, 0.003),child:Container(color: Colors.grey[300]),),
                                Container(
                                  padding: EdgeInsets.only(left: getDevicewidth(context, 0.03),right: getDevicewidth(context, 0.03)),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(onPressed: (){}, child: Text("Invoice")),
                                        Icon(Icons.arrow_forward_ios,size: 16,color: Colors.blueAccent,)
                                      ]),
                                ),

                                // ElevatedButton(onPressed: (){
                                //   context.read<OrderBloc>().add(BuyAgainEvent(orderid: state.order[index].orderId!,context: context));
                                //   //context.read<OrderBloc>().add(OrderScreenEvent());
                                //   }, child: Text("Buy Again"),style: ElevatedButton.styleFrom(primary: Colors.orangeAccent)),
                                // ElevatedButton(onPressed: (){}, child: Text("Invoice")),
                                //   ],
                                // ),
                              ],
                            )



                          ],
                        ),
                      );
                    }),
                  )

                ],
              );
            }
            else{
              return Text("Something went wrong");
            }
          }),
        )

      );

  }
}








// class OrderScreen extends StatefulWidget {
//   final int orderid;
//   final bool iscart;
//   final List<CartModel>? products;
//   final ProductModel? singleProduct;
//   final int totalAmount;
//   final int totalOfferAmount;
//   const OrderScreen({
//     Key? key,
//     required this.orderid,
//     required this.iscart,
//     this.products,
//     this.singleProduct,
//     required this.totalAmount,
//     required this.totalOfferAmount
//
//   }) : super(key: key);
//
//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }
// int totalAmount=0;
// class _OrderScreenState extends State<OrderScreen> {
//   @override
//   Widget build(BuildContext context) {
//     int sec = DateTime.now().millisecondsSinceEpoch;
//     print(sec);
//     return Scaffold(
//       appBar: AppBar(title: Text("Your orders"),),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(8),
//               child: Text("Order Id: "+widget.orderid.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
//             ),
//             Container(
//               padding: EdgeInsets.all(8),
//               child: ListView.builder(
//                   itemCount:widget.iscart?widget.products!.length:1,
//                   shrinkWrap: true,
//                   itemBuilder: (contex,index){
//                     return Container(
//                       height: getDeviceheight(context, 0.08),
//                       child: Card(
//                         child: Container(
//                           padding: EdgeInsets.all(8),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               widget.iscart?Text(widget.products![index].name!):Text(widget.singleProduct!.name!),
//                               Spacer(),
//                               widget.iscart?Text("Quantity: "+widget.products![index].quantity.toString()):Text("Quantity: 1"),
//                               Spacer(),
//                               widget.iscart?Text(widget.products![index].offerPrice.toString()):Text(widget.singleProduct!.offerPrice.toString()),
//                               Text(totalAmount.toString()),
//                             ],),
//                         ),
//                       ),
//                     );
//                   }),
//             ),
//             ExpansionTile(
//               title: Text('Products Summary',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
//               subtitle: widget.iscart?Text('Total Products Ordered: '+widget.products!.length.toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15)):Text('Total Products Ordered: 1',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   child: ListView.builder(
//                       itemCount:widget.iscart?widget.products!.length:1,
//                       shrinkWrap: true,
//                       itemBuilder: (contex,index){
//                         return Card(
//                           child: Container(
//                             padding: EdgeInsets.all(8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Image(
//                                   height: 40,
//                                   width: 40,
//                                   image: NetworkImage(widget.iscart?widget.products![index].productImg!:widget.singleProduct!.productImg!),
//                                 ),
//                                 Text(widget.iscart?widget.products![index].name!:widget.singleProduct!.name!),
//                                 Spacer(),
//                                 // Text(widget.quantity[index]),
//                                 // Spacer(),
//                                 widget.iscart?Text("Price: "+widget.products![index].offerPrice.toString()):Text("Price: "+widget.singleProduct!.offerPrice.toString()),
//                                 Spacer(),
//                                 widget.iscart?Text("Quantity: "+widget.products![index].quantity.toString()):Text("Quantity: 1"),
//
//                               ],),
//                           ),
//                         );
//                       }),
//                 ),
//               ],
//             ),
//             Container(
//               padding: EdgeInsets.all(8),
//               child: Row(children: [Spacer(),Text("Total Amount Saved: "+widget.totalOfferAmount.toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.green))],),
//             ),
//             Container(
//               padding: EdgeInsets.all(8),
//               child: Row(children: [Spacer(),Text("Total Amount: "+widget.totalAmount.toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15))],),
//             )
//           ],
//         ),
//       ),
//       floatingActionButton:  FloatingActionButton.extended(
//         elevation: 0.0,
//         // child: Row(children: [Text("Checkout"),Icon(Icons.check)],) ,
//         backgroundColor: new Color(0xFFE57373),
//         label: Row(children: [Text("Place Order"),SizedBox(width: 10,),Icon(Icons.check_circle)],),
//         onPressed: (){
//
//         },
//       ),
//     );
//
//   }
// }