import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:todo_getx/models/user_model.dart';
import 'package:todo_getx/services/user_service.dart';
import 'package:todo_getx/widgets/explorer_page_cards.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(color: Color.fromARGB(255, 236, 164, 112)),
          child: Column(
            children: [
              AllUserList(),
            ],
          )),
    );
  }
}

class AllUserList extends StatelessWidget {
  final userServiceController = Get.put(UserService());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: userServiceController.getAllUsers(),
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
                  MyUser user =
                      MyUser.fromMap(snapshot.data!.docs[index].data());
                  return ExploreCardWidget(user: user);
                }),
          );
        });
  }
}
