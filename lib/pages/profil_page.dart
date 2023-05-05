import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_getx/services/post_service.dart';
import 'package:todo_getx/widgets/post_card_widget.dart';

import '../models/post_model.dart';
import '../widgets/profil_card_widget.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(color: Color.fromARGB(255, 236, 164, 112)),
      child: Column(
        children: [
          ProfileCardWidget(),
          CurrentUserPosts(),
        ],
      ),
    ));
  }
}

class CurrentUserPosts extends StatelessWidget {
  final postServiceController = Get.put(PostService());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: postServiceController.currentUserPostsStream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: snapshot.data?.docs.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  MyPost post = MyPost.fromMap(snapshot.data!.docs[index].data());
                  return MyPostCard(post: post);
                }),
          );
        });
  }
}
