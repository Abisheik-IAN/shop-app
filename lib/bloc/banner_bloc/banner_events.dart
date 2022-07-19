import 'package:equatable/equatable.dart';

import '../../model/banner_model.dart';


abstract class BannerEvents extends Equatable{
  const BannerEvents();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadBanners extends BannerEvents{}

class UpdateBanners extends BannerEvents{
  final List<BannerModel> banners;

  const UpdateBanners(this.banners);

  @override
  // TODO: implement props
  List<Object?> get props => [banners];
}
class PageIncrementEvent extends BannerEvents{
  final int Pageno;
  const PageIncrementEvent(this.Pageno);
}