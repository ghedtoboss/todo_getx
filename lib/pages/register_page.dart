import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_contains/contains.dart';
import '../services/user_service.dart';

class RegisterPage extends StatelessWidget {
  final userServiceController = Get.put(UserService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(color: Color.fromARGB(255, 236, 164, 112)),
        child: PageView(
          children: <Widget>[
            RegisterOne(userServiceController: userServiceController),
          ],
        ),
      ),
    );
  }
}

class RegisterOne extends StatelessWidget {
  const RegisterOne({
    super.key,
    required this.userServiceController,
  });

  final UserService userServiceController;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          padding: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 30),
          child: FittedBox(
            child: Text(
              "Kayıt Ol!",
              style: GoogleFonts.lobsterTwo(
                  textStyle: TextStyle(fontSize: 50, color: Colors.white)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
          child: MyTextfield(
            controller: userServiceController.adSoyadController,
            yazi: "Ad Soyad",
            isSecured: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
          child: MyTextfield(
            controller: userServiceController.emailController,
            yazi: "E-mail",
            isSecured: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
          child: MyTextfield(
            controller: userServiceController.passwordController,
            yazi: "Şifre",
            isSecured: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
          child: MyTextfield(
            controller: userServiceController.rePasswordController,
            yazi: "Şifre tekrar",
            isSecured: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: KayitIleri(),
        ),
      ],
    );
  }
}
