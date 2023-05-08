import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_getx/models/user_model.dart';
import 'package:todo_getx/pages/another_users_page.dart';

import '../app_contains/contains.dart';
import '../services/user_service.dart';

class ExploreCardWidget extends StatelessWidget {
  const ExploreCardWidget({
    super.key,
    required this.user,
  });

  final MyUser user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //ToDo kullanıcının profiline ulaşacak
        Get.to(AnotherUsersPage(user: user));
      },
      child: Container(
          width: Get.width,
          height: Get.height * 0.32,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Color.fromARGB(255, 60, 50, 50),
              child: Column(
                children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          user.adSoyad.length > 30
                                              ? user.adSoyad.substring(0, 30)
                                              : user.adSoyad,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          //user.adSoyad,
                                          style: GoogleFonts.lobsterTwo(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20)),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          user.isAlani,
                                          style: GoogleFonts.lobsterTwo(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: TakipButton(
                                      userId: user.uid,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text(
                                          "Takipçi: ${user.takipciListesi.length}",
                                          style: GoogleFonts.lobsterTwo(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        width: Get.width * 0.2,
                                        height: Get.height * 0.1,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(user
                                                            .imageUrl ==
                                                        ""
                                                    ? "https://firebasestorage.googleapis.com/v0/b/todosocial-37efa.appspot.com/o/nopp.png?alt=media&token=a7867c84-6724-431d-8b9b-c5429d43feae"
                                                    : user.imageUrl),
                                                fit: BoxFit.fill))),
                                    Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Takip: ${user.takipListesi.length}",
                                          style: GoogleFonts.lobsterTwo(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Container(
                                    width: Get.width * 0.95,
                                    height: Get.height * 0.1,
                                    child: Text(
                                      user.hakkimda!,
                                      textAlign: TextAlign.left,
                                      maxLines: 4,
                                      overflow: TextOverflow.visible,
                                      style: GoogleFonts.lobsterTwo(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15)),
                                    ),
                                  )),
                            ]),
                      ]),
                ],
              ))),
    );
  }
}
