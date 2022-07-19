import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/banner_model.dart';
import 'base_banner_repo.dart';


class BannerRepo extends BaseBannerImageRepo {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late QuerySnapshot querySnapshot;
  @override
  Future<List<BannerModel>> getAllImages() async {
    querySnapshot = await _firebaseFirestore.collection('banner_images').get();

    return querySnapshot.docs.map((e) => BannerModel.fromSnapshot(e)).toList();
  }
}
