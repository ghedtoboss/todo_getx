import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_getx/app_contains/contains.dart';
import 'package:todo_getx/services/post_service.dart';

import '../services/user_service.dart';

class AddPostPage extends StatelessWidget {
  final userServiceController = Get.put(UserService());
  final PostServiceController = Get.put(PostService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff6ebeb),
        title: Text(
          "Yeni Görev",
          style: GoogleFonts.lobsterTwo(
              textStyle: TextStyle(fontSize: 20, color: Colors.black)),
        ),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(color: Color.fromARGB(255, 236, 164, 112)),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 30),
              child: FittedBox(
                child: Text(
                  "Yeni Görevini Ekle!",
                  style: GoogleFonts.lobsterTwo(
                      textStyle: TextStyle(fontSize: 50, color: Colors.white)),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),
              child: AddPostTitleTextField(
                controller: PostServiceController.newTodoTitleController,
                yazi: "Başlık",
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),
              child: AddPostContentTextField(
                  controller: PostServiceController.newTodoContentController,
                  yazi: "Görevim"),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),
              child: AddPostButton(),
            ),
          ],
        ),
      ),
    );
  }
}
