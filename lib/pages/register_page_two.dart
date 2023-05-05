import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_getx/controller/is_listesi.dart';

import '../app_contains/contains.dart';
import '../services/user_service.dart';

class RegisterPageTwo extends StatelessWidget {
  RegisterPageTwo({
    super.key,
    required this.userServiceController,
  });
  final listeController = Get.put(IsListesi());
  final UserService userServiceController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(color: Color.fromARGB(255, 236, 164, 112)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 5, right: 5),
            child: FittedBox(
              child: Text(
                "ToDo Social!",
                style: GoogleFonts.lobsterTwo(
                    textStyle: TextStyle(fontSize: 75, color: Colors.white)),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 30),
            child: FittedBox(
              child: Text(
                "Kayıt Ol!",
                style: GoogleFonts.lobsterTwo(
                    textStyle: TextStyle(fontSize: 50, color: Colors.white)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: CustomDropdown.search(
              hintText: "İş alanınızı seçiniz",
              items: listeController.islistesi,
              controller: userServiceController.selectedJobController,
              fillColor: Color(0xfff6ebeb),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
            child: SizedBox(
              height: Get.height * 0.3,
              child: MyTextfield2(
                controller: userServiceController.hakkimdaController,
                yazi: "Hakkımda",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: KayitOlButton(),
          ),
        ],
      ),
    ));
  }
}
