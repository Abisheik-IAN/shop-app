


import '../../model/banner_model.dart';

abstract class BaseBannerImageRepo{
  Future<List<BannerModel>> getAllImages();
}