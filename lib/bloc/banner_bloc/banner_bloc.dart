import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/banner_repo/banner_repo.dart';
import 'banner_events.dart';
import 'banner_state.dart';



class BannerBloc extends Bloc<BannerEvents, BannerState> {
  final BannerRepo _bannerRepo;
  BannerBloc({required BannerRepo bannerRepo})
      : _bannerRepo = bannerRepo,
        super(BannerLoading()){


    on<BannerEvents>((events, emit) async {
      if (events is LoadBanners || events is UpdateBanners) {
        emit(BannerLoading());/// It emits the loading state..
        final  banner=await _bannerRepo.getAllImages();///It receive all the product image from the firestore query response...
            emit(BannerLoaded(banners: banner));///It emits the loaded state with the product value..

          }
      if(events is PageIncrementEvent){
        final pageno=events.Pageno;
        emit(PageIncrementState(pageno));
      }

    });
  }

}
