// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shop_app_bloc/bloc/product_bloc/product_events.dart';
// import 'package:shop_app_bloc/bloc/product_bloc/product_state.dart';
// import 'package:shop_app_bloc/model/product_model.dart';
//
// import '../../repository/product_repo/product_repo.dart';
//
//
//
// class AddProductBloc extends Bloc<ProductEvents,ProductState>{
//   final ProductRepo _productRepo;
//   AddProductBloc({required ProductRepo productRepo}) :_productRepo=productRepo, super(AddProductLoadingState()){
//     on<AddProductNavigationEvents>((events, emit) {
//       emit(AddProductNavigationState());///It is used to navigate to the Add product page..
//     });
//     on<ProductEvents>((event, emit)async{
//
//       if(event is UpdateAddProductEvent) {
//         emit(AddProductLoadingState());
//         print("inside events" + event.name);
//         ProductModel(name: event.name,
//             offerPrice: event.offerprice,
//             price: event.price,
//             productImg: event.productImg,
//             timestamp: event.timeStamp);
//         print(ProductModel().toJson());
//         await _productRepo.addProducts(
//             event.name, event.offerprice, event.price, event.productImg);///The value of new products(name,price,offer_price,Image) send to firestore..
//         emit(AddProductLoadedState());
//       }
//     });
//     on<AddProductWidgetEvent>((event, emit){
//       emit(AddProductWidgetState(name: true, price: true, offerprice: true, imageurl: true));///To Display the Add new product UI
//     });
//
//     on<FieldValidationErrorEvent>((event, emit) {
//       if(event.name.isNotEmpty && event.imageurl.isNotEmpty && event.price.toString().isNotEmpty && event.offerprice.toString().isNotEmpty){
//         if(int.parse(event.offerprice)<int.parse(event.price)) {
//           emit(FieldValidationSuccessState());///This state is emitted when there is not error..
//         }
//         else{
//           emit(PriceDiffError());///This state is emitted when the offer price is more the the normal price...
//         }
//       }else{
//         emit(AddProductWidgetState(name: event.name.isNotEmpty, price: event.price.isNotEmpty, offerprice: event.offerprice.isNotEmpty, imageurl: event.imageurl.isNotEmpty));///This state is emitted when(name/price/offer price/ image url) field is empty..
//       }
//     });
//   }
//
// }