import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todo_getx/models/post_model.dart';
import 'package:todo_getx/services/user_service.dart';

class PostService extends GetxController {
  final userServiceController = Get.put(UserService());
  TextEditingController newTodoTitleController =
      TextEditingController(); //addPost metodunda
  TextEditingController newTodoContentController =
      TextEditingController(); //addPost metodunda

  Future<void> addPost() async {
    try {
      final DocumentReference postRef =
          FirebaseFirestore.instance.collection("Posts").doc();

      MyPost post = MyPost(
        id: postRef.id,
        title: newTodoTitleController.text.toUpperCase(),
        content: newTodoContentController.text,
        author: userServiceController.currentUserUid!,
        isFinished: false,
        comments: {},
        likes: [],
        date:
            "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}",
      );
      postRef.set(post.toMap());
      newTodoTitleController.clear();
      newTodoContentController.clear();
    } catch (e) {
      newTodoTitleController.clear();
      newTodoContentController.clear();
      Fluttertoast.showToast(msg: "Bir hata meydana geldi");
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentUserPosts();
  }

  //currentUser postları
  Stream<QuerySnapshot<Map<String, dynamic>>> getCurrentUserPosts() {
    return FirebaseFirestore.instance
        .collection("Posts")
        .where("author", isEqualTo: userServiceController.currentUserUid)
        .snapshots();
  }

  //another user posts;
  Stream<QuerySnapshot<Map<String, dynamic>>>? getThisUserPosts(String userId) {
    return FirebaseFirestore.instance
        .collection("Posts")
        .where("author", isEqualTo: userId)
        .snapshots();
  }

  //home page posts;
  Stream<QuerySnapshot<Map<String, dynamic>>>? getHomePosts() {
    return FirebaseFirestore.instance
        .collection("Posts")
        //.where("author", whereIn: userServiceController.followList.value)
        .snapshots();
  }

  //post beğenme özelliği;
  void likePost(String postId) {
    FirebaseFirestore.instance.collection("Posts").doc(postId).update({
      "likes": FieldValue.arrayUnion([userServiceController.currentUserUid])
    });
  }

  void dislikePost(String postId) {
    FirebaseFirestore.instance.collection("Posts").doc(postId).update({
      "likes": FieldValue.arrayRemove([userServiceController.currentUserUid])
    });
  }
}
