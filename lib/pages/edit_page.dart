import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_getx/controller/is_listesi.dart';
import 'package:todo_getx/services/user_service.dart';

import '../app_contains/contains.dart';

class EditPage extends StatelessWidget {
  TextEditingController adSoyadEditController = TextEditingController();
  TextEditingController hakkimdaEditController = TextEditingController();
  TextEditingController jobEditController = TextEditingController();

  final listeController = Get.put(IsListesi());
  final userServiceController = Get.put(UserService());
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff6ebeb),
        title: Text(
          "Düzenle",
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
                  "Profili Düzenle!",
                  style: GoogleFonts.lobsterTwo(
                      textStyle: TextStyle(fontSize: 50, color: Colors.white)),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),
              child: MyTextfield(
                controller: adSoyadEditController,
                yazi: "Ad Soyad",
                isSecured: false,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),
              child: CustomDropdown.search(
                hintText: "İş alanınızı seçiniz",
                items: listeController.islistesi,
                controller: jobEditController,
                fillColor: Color(0xfff6ebeb),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),
              child: MyTextfield2(
                  controller: hakkimdaEditController, yazi: "Hakkimda"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  final userDocRef = await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(user?.uid);
                  if (adSoyadEditController.text != "") {
                    await userDocRef.update(<String, String>{
                      "adSoyad": adSoyadEditController.text
                    });
                  }
                  if (hakkimdaEditController.text != "") {
                    await userDocRef.update(<String, String>{
                      "hakkimda": hakkimdaEditController.text
                    });
                  }
                  if (jobEditController.text != "") {
                    await userDocRef.update(
                        <String, String>{"isAlani": jobEditController.text});
                  }
                  Get.back();
                },
                child: Text(
                  "Değişiklikleri Kaydet",
                  style: GoogleFonts.lobsterTwo(
                      textStyle: TextStyle(fontSize: 12, color: Colors.black)),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Color(0xfff6ebeb)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
