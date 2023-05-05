import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_getx/services/user_service.dart';

class ProfileCardWidget extends StatelessWidget {
  UserService userServiceController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                            Column(
                              children: [
                                Obx(() => FittedBox(
                                      child: Text(
                                        userServiceController.adSoyad.value,
                                        style: GoogleFonts.lobsterTwo(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30)),
                                      ),
                                    )),
                                Obx(() => FittedBox(
                                      child: Text(
                                        userServiceController.isAlani.value,
                                        style: GoogleFonts.lobsterTwo(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15)),
                                      ),
                                    ))
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
                                  Obx(() => Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Text(
                                            "Takipçi: ${userServiceController.followerList.value.length}",
                                            style: GoogleFonts.lobsterTwo(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15)),
                                          ),
                                        ),
                                      )),
                                  Obx(() => InkWell(
                                        onTap: () => userServiceController
                                            .uploadImageAndUpdateImageUrl(),
                                        child: Container(
                                            width: Get.width * 0.2,
                                            height: Get.height * 0.1,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        userServiceController
                                                                    .imageUrl
                                                                    .value ==
                                                                ""
                                                            ? "https://firebasestorage.googleapis.com/v0/b/todosocial-37efa.appspot.com/o/nopp.png?alt=media&token=a7867c84-6724-431d-8b9b-c5429d43feae"
                                                            : userServiceController
                                                                .imageUrl
                                                                .value),
                                                    fit: BoxFit.fill))),
                                      )),
                                  Obx(() => Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Takip: ${userServiceController.followList.value.length}",
                                            style: GoogleFonts.lobsterTwo(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15)),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                                    child: Text(
                                      "ToDo: 0",
                                      style: GoogleFonts.lobsterTwo(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Obx((() => Container(
                                    width: Get.width * 0.95,
                                    height: Get.height * 0.1,
                                    child: Text(
                                      userServiceController.hakkimda.value,
                                      textAlign: TextAlign.left,
                                      maxLines: 4,
                                      overflow: TextOverflow.visible,
                                      style: GoogleFonts.lobsterTwo(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15)),
                                    ),
                                  ))),
                            )
                          ]),
                    ]),
              ],
            )));
  }
}
