import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:todo_getx/services/post_service.dart';
import 'package:todo_getx/widgets/explorer_page_cards.dart';

import '../models/post_model.dart';
import '../models/user_model.dart';
import '../widgets/post_card_widget.dart';

class AnotherUsersPage extends StatelessWidget {
  const AnotherUsersPage({super.key, required this.user});
  final MyUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Color(0xfff6ebeb),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(color: Color.fromARGB(255, 236, 164, 112)),
        child: Column(
          children: [ExploreCardWidget(user: user), ThisUserPosts(user: user)],
        ),
      ),
    );
  }
}

class ThisUserPosts extends StatelessWidget {
  ThisUserPosts({super.key, required this.user});
  final MyUser user;
  final postServiceController = Get.put(PostService());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: postServiceController.getThisUserPosts(user.uid),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          var snapList = snapshot.data?.docs;

          return Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: snapshot.data?.docs.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  MyPost post =
                      MyPost.fromMap(snapshot.data!.docs[index].data());
                  return MyPostCard(post: post);
                }),
          );
        });
  }
}
