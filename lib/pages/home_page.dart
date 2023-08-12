import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:todo_getx/pages/add_post_page.dart';
import 'package:todo_getx/services/post_service.dart';
import 'package:todo_getx/widgets/home_cards.dart';

import '../models/post_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddPostPage());
        },
        child: Icon(
          Icons.add_circle,
          color: Colors.black,
        ),
        backgroundColor: Color(0xfff6ebeb),
      ),
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(color: Color.fromARGB(255, 236, 164, 112)),
          child: Column(
            children: [
              HomePosts()
            ],
          ),
        ),
      ),
    );
  }
}

class HomePosts extends StatelessWidget {
  HomePosts({super.key});
  final postServiceController = Get.put(PostService());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: postServiceController.getHomePosts(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          //var snapList = snapshot.data?.docs;

          return Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: snapshot.data?.docs.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  MyPost post =
                      MyPost.fromMap(snapshot.data!.docs[index].data());

                  return HomeCards(post: post);
                }),
          );
        });
  }
}


