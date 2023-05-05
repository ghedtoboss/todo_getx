import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_getx/controller/bottom_bar_controller.dart';
import 'package:todo_getx/pages/edit_page.dart';

import '../services/user_service.dart';

class BottomBarAllPages extends StatelessWidget {
  final bottomBarController = Get.put(BottomBarController());
  final userServiceController = Get.put(UserService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(EditPage());
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.black,
                ))
          ],
          leading: IconButton(
              onPressed: () {
                userServiceController.logOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              )),
          backgroundColor: Color(0xfff6ebeb),
          title: Text(
            "ToDo Social!",
            style: GoogleFonts.lobsterTwo(
                textStyle: TextStyle(fontSize: 20, color: Colors.black)),
          ),
        ),
        body: Obx(() =>
            bottomBarController.pages[bottomBarController.pageIndex.value]),
        bottomNavigationBar: Obx(
          () => Container(
            height: Get.height * 0.06,
            decoration: BoxDecoration(
              color: Color(0xfff6ebeb),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    enableFeedback: false,
                    iconSize: 30,
                    onPressed: () {
                      bottomBarController.pageIndex.value = 0;
                    },
                    icon: bottomBarController.pageIndex.value == 0
                        ? const Icon(Icons.home_filled)
                        : const Icon(Icons.home_outlined)),
                IconButton(
                    enableFeedback: false,
                    iconSize: 30,
                    onPressed: () {
                      bottomBarController.pageIndex.value = 1;
                    },
                    icon: bottomBarController.pageIndex.value == 1
                        ? const Icon(Icons.search_rounded)
                        : const Icon(Icons.search_outlined)),
                IconButton(
                    enableFeedback: false,
                    iconSize: 30,
                    onPressed: () {
                      bottomBarController.pageIndex.value = 2;
                    },
                    icon: bottomBarController.pageIndex.value == 2
                        ? const Icon(Icons.person_2)
                        : const Icon(Icons.person_2_outlined)),
              ],
            ),
          ),
        ));
  }
}
