
import 'package:equatable/equatable.dart';
import 'package:shopapp_multiplatform/model/order_model.dart';

abstract class OrderState extends Equatable{
  const OrderState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class OrderLoadingState extends OrderState{}
class OrderLoadedState extends OrderState{
  final List<OrdersModel> order;
  const OrderLoadedState({required this.order});
  @override
  // TODO: implement props
  List<Object?> get props => [order];
}

class AddOrdersLoadingState extends OrderState{}
class AddOrdersLoadedState extends OrderState{}

class PaymentMethodState extends OrderState{}
class OrderScreenState extends OrderState{}
class BillingScreenState extends OrderState{}
//Used for navigation
class PaymentMethodNavigationState extends OrderState{}
class OrderScreenNavigationState extends OrderState{}
class BillingScreenNavigationState extends OrderState{}