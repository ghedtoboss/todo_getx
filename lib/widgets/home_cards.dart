import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_getx/controller/home_card_ctrl.dart';

import '../models/post_model.dart';
import '../models/user_model.dart';

class HomeCards extends StatefulWidget {
  HomeCards({super.key, required this.post});
  final MyPost post;

  @override
  State<HomeCards> createState() => _HomeCardsState();
}

class _HomeCardsState extends State<HomeCards> {
  String? authorName;
  String? authorImageUrl;

  Future<void> getUserNameAndPhoto() async {
    var data = await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.post.author)
        .get();
    authorName = data["adSoyad"];
    authorImageUrl = data["imageUrl"];

    setState(() {
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserNameAndPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      height: Get.height * 0.3,
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
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4, top: 4),
                          child: Container(
                              width: Get.width * 0.15,
                              height: Get.height * 0.075,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(authorImageUrl ??
                                          "https://firebasestorage.googleapis.com/v0/b/todosocial-37efa.appspot.com/o/nopp.png?alt=media&token=a7867c84-6724-431d-8b9b-c5429d43feae"),
                                      fit: BoxFit.fill))),
                        ),
                        Text(
                          authorName ?? "Bilgi yok",
                          style: GoogleFonts.lobsterTwo(
                              textStyle:
                                  TextStyle(fontSize: 10, color: Colors.white)),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        widget.post.title,
                        maxLines: 1,
                        style: GoogleFonts.lobsterTwo(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 15)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 5),
                      child: Text(
                        widget.post.date ?? 'Tarih yok',
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
                      widget.post.content,
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
                  widget.post.isFinished == true
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.cancel,
                          color: Colors.white,
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
                            widget.post.likes.length.toString(),
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
                            widget.post.comments.length.toString(),
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
}
