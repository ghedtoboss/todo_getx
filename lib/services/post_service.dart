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
}
