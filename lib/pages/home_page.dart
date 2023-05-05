import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:todo_getx/pages/add_post_page.dart';

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
        child: Text("Home"),
      ),
    );
  }
}
