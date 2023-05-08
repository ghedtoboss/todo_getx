import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/post_model.dart';

class HomeCardController extends GetxController {
  RxString authorName = "".obs;
  RxString authorImageUrl = "".obs;

  Future<void> getAuthorNameAndImage(MyPost post) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(post.author)
        .snapshots()
        .listen((userDoc) {
      if (userDoc.exists) {
        final Map<String, dynamic> data =
            userDoc.data() as Map<String, dynamic>;

        authorName.value = data["adSoyad"];
        authorImageUrl.value = data["imageUrl"];
      }
    });
  }
}
