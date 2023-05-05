import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_getx/models/post_model.dart';
import 'package:todo_getx/services/user_service.dart';

class MyPostCard extends StatelessWidget {
  const MyPostCard({
    super.key,
    required this.post,
  });

  final MyPost post;

  bool isThisMyPost() {
    final userServiceController = Get.put(UserService());
    var myPost = post.author == userServiceController.currentUserUid;
    return myPost;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      height: Get.height * 0.22,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Color.fromARGB(255, 60, 50, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        post.title,
                        maxLines: 1,
                        style: GoogleFonts.lobsterTwo(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 15)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 5),
                      child: Text(
                        post.date ?? 'Tarih yok',
                        style: GoogleFonts.lobsterTwo(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 15)),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Container(
                    height: Get.height * 0.11,
                    width: Get.width * 0.95,
                    child: Text(
                      post.content,
                      maxLines: 5,
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.lobsterTwo(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  post.isFinished == true
                      ? InkWell(
                          onTap: () async {
                            await isThisMyPost();
                            showAlertDialog(context);
                          },
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                        )
                      : InkWell(
                        onTap: () async {
                            await isThisMyPost();
                            showAlertDialog(context);
                          },
                        child: Icon(
                            Icons.cancel,
                            color: Colors.white,
                          ),
                      ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: IconButton(
                              onPressed: () {
                                //ToDo beğenme fonksiyonu
                              },
                              icon: Icon(
                                Icons.thumb_up_alt_outlined,
                                color: Colors.white,
                              )),
                        ),
                        Center(
                          child: Text(
                            post.likes.length.toString(),
                            style: GoogleFonts.lobsterTwo(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 10)),
                          ),
                        ),
                        Center(
                          child: IconButton(
                              onPressed: () {
                                //ToDo yorum fonksiyonu
                              },
                              icon: Icon(
                                Icons.comment_outlined,
                                color: Colors.white,
                              )),
                        ),
                        Center(
                          child: Text(
                            post.comments.length.toString(),
                            style: GoogleFonts.lobsterTwo(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //alertdialog
  showAlertDialog(
    BuildContext context,
  ) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Kapat"),
      onPressed: () {
        Get.back();
      },
    );
    Widget didntButton = TextButton(
      child: Text("Yapılmadı"),
      onPressed: () async {
        updateIsFinishedFalse();
        Get.back();
      },
    );

    Widget didButton = TextButton(
      child: Text("Tamamlandı"),
      onPressed: () {
        //todo update isFinished
        updateIsFinishedTrue();
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Bu hedefini gerçekleştirdin mi?"),
      content: Text(post.content),
      actions: [cancelButton, didntButton, didButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> updateIsFinishedTrue() async {
    //isFinished olayını güncelliyorum.
    //dökümana ulaşmak için;
    var postDocRef =
        await FirebaseFirestore.instance.collection("Posts").doc(post.id);
    await postDocRef.update(<String, bool>{'isFinished': true});
  }

  Future<void> updateIsFinishedFalse() async {
    //dökümana ulaşmak için;
    var postDocRef =
        await FirebaseFirestore.instance.collection("Posts").doc(post.id);
    await postDocRef.update(<String, bool>{'isFinished': false});
  }
}
