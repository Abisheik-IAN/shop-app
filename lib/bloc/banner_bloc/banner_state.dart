import 'package:equatable/equatable.dart';

import '../../model/banner_model.dart';


abstract class BannerState extends Equatable{
  const BannerState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BannerLoading extends BannerState{}

class BannerLoaded extends BannerState{
  final List<BannerModel> banners;
  const BannerLoaded({required this.banners});
  @override
  // TODO: implement props
  List<Object?> get props => [banners];
}
class PageIncrementState extends BannerState{
  final int Pageno;
  const PageIncrementState(this.Pageno);
}
