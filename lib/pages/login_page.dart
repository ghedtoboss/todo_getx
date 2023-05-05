import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_getx/app_contains/contains.dart';
import 'package:todo_getx/services/user_service.dart';

import 'register_page.dart';

class LoginPage extends StatelessWidget {
  TextEditingController kullaniciAdiController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final userServiceController = Get.put(UserService());

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
            Container(
              width: Get.width,
              height: Get.height * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("asset/images/146.png"),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
              child: MyTextfield(
                controller: userServiceController.emailController,
                yazi: "E-mail",
                isSecured: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: MyTextfield(
                controller: userServiceController.passwordController,
                yazi: "Şifre",
                isSecured: true,
              ),
            ),
            BeniHatirlaCircle(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LoginButton(),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: TextButton(
                  onPressed: () {
                    Get.to(RegisterPage());
                  },
                  child: Text(
                    "Kayıt Ol",
                    style: GoogleFonts.lobsterTwo(
                        textStyle:
                            TextStyle(fontSize: 15, color: Color(0xfff6ebeb))),
                  )),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  "Şifremi unuttum",
                  style: GoogleFonts.lobsterTwo(
                      textStyle:
                          TextStyle(fontSize: 15, color: Color(0xfff6ebeb))),
                )),
          ],
        ),
      ),
    );
  }
}
