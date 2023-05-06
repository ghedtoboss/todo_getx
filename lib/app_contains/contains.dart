import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_getx/pages/login_page.dart';
import 'package:todo_getx/pages/my_bottom_bar.dart';
import 'package:todo_getx/services/post_service.dart';
import 'package:todo_getx/services/user_service.dart';

import '../pages/register_page_two.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield(
      {super.key,
      required this.controller,
      required this.yazi,
      required this.isSecured});

  final TextEditingController controller;
  final yazi;
  final bool isSecured;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: TextStyle(color: Colors.black, fontSize: 16),
        controller: controller,
        obscureText: isSecured,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            fillColor: Color(0xfff6ebeb),
            filled: true,
            labelText: yazi,
            labelStyle: GoogleFonts.lobsterTwo(
                textStyle: TextStyle(fontSize: 14, color: Colors.black)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(20)))));
  }
}

class MyTextfield2 extends StatelessWidget {
  const MyTextfield2({super.key, required this.controller, required this.yazi});

  final TextEditingController controller;
  final yazi;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: 250,
        style: TextStyle(color: Colors.black, fontSize: 16),
        controller: controller,
        maxLines: 4,
        onChanged: (String value) {
          int lineCount = value.split('\n').length;
          if (lineCount > 4) {
            String newValue = value.substring(0, value.lastIndexOf('\n'));
            controller.value = controller.value.copyWith(text: newValue);
          }
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            fillColor: Color(0xfff6ebeb),
            filled: true,
            labelText: yazi,
            labelStyle: GoogleFonts.lobsterTwo(
                textStyle: TextStyle(fontSize: 14, color: Colors.black)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(20)))));
  }
}

class BeniHatirlaCircle extends StatelessWidget {
  const BeniHatirlaCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "beni hatırla",
      style: GoogleFonts.lobsterTwo(textStyle: TextStyle(fontSize: 10)),
    );
  }
}

class LoginButton extends StatelessWidget {
  UserService userServiceController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.4,
      child: ElevatedButton(
        onPressed: () async {
          await userServiceController.girisYap();
          Get.to(BottomBarAllPages());
        },
        child: Text(
          "Giriş",
          style: GoogleFonts.lobsterTwo(
              textStyle: TextStyle(fontSize: 12, color: Colors.black)),
        ),
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color(0xfff6ebeb)),
      ),
    );
  }
}

class KayitIleri extends StatelessWidget {
  final userServiceController = Get.put(UserService());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.4,
      child: ElevatedButton(
        onPressed: () {
          Get.to(RegisterPageTwo(
            userServiceController: userServiceController,
          ));
        },
        child: Text(
          "İleri",
          style: GoogleFonts.lobsterTwo(
              textStyle: TextStyle(fontSize: 12, color: Colors.black)),
        ),
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color(0xfff6ebeb)),
      ),
    );
  }
}

class KayitOlButton extends StatelessWidget {
  final userServiceController = Get.put(UserService());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.4,
      child: ElevatedButton(
        onPressed: () async {
          if (userServiceController.passwordController.text ==
              userServiceController.rePasswordController.text) {
            await userServiceController.createUser();
            Get.to(LoginPage());
          } else {
            Fluttertoast.showToast(
                msg: "Şifreler uyuşmuyor", backgroundColor: Colors.redAccent);
          }
        },
        child: Text(
          "Kayıt Ol",
          style: GoogleFonts.lobsterTwo(
              textStyle: TextStyle(fontSize: 12, color: Colors.black)),
        ),
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color(0xfff6ebeb)),
      ),
    );
  }
}

class AddPostTitleTextField extends StatelessWidget {
  const AddPostTitleTextField({
    super.key,
    required this.controller,
    required this.yazi,
  });

  final TextEditingController controller;
  final yazi;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: TextStyle(color: Colors.black, fontSize: 16),
        controller: controller,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            fillColor: Color(0xfff6ebeb),
            filled: true,
            labelText: yazi,
            labelStyle: GoogleFonts.lobsterTwo(
                textStyle: TextStyle(fontSize: 14, color: Colors.black)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(20)))));
  }
}

class AddPostContentTextField extends StatelessWidget {
  AddPostContentTextField(
      {super.key, required this.yazi, required this.controller});
  final TextEditingController controller;
  final String yazi;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: 315,
        style: TextStyle(color: Colors.black, fontSize: 16),
        controller: controller,
        maxLines: 5,
        onChanged: (String value) {
          int lineCount = value.split('\n').length;
          if (lineCount > 5) {
            String newValue = value.substring(0, value.lastIndexOf('\n'));
            controller.value = controller.value.copyWith(text: newValue);
          }
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            fillColor: Color(0xfff6ebeb),
            filled: true,
            labelText: yazi,
            labelStyle: GoogleFonts.lobsterTwo(
                textStyle: TextStyle(fontSize: 14, color: Colors.black)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(20)))));
  }
}

class AddPostButton extends StatelessWidget {
  final userServiceController = Get.put(UserService());
  final postServiceController = Get.put(PostService());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.4,
      child: ElevatedButton(
        onPressed: () async {
          await postServiceController.addPost();
          Get.back();
        },
        child: Text(
          "Ekle!",
          style: GoogleFonts.lobsterTwo(
              textStyle: TextStyle(fontSize: 12, color: Colors.black)),
        ),
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color(0xfff6ebeb)),
      ),
    );
  }
}

class TakipButton extends StatelessWidget {
  TakipButton({super.key, required this.userId});
  final userId;
  final userServiceController = Get.put(UserService());
  @override
  Widget build(BuildContext context) {
    return userServiceController.isFollow(userId) == true
        ? ElevatedButton(
            onPressed: () async {
              //ToDo takibi bırakma fonksiyonu
              userServiceController.unFollowUser(userId);
            },
            child: Text(
              "Takibi bırak!",
              style: GoogleFonts.lobsterTwo(
                  textStyle: TextStyle(fontSize: 12, color: Colors.black)),
            ),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: Color(0xfff6ebeb)),
          )
        : ElevatedButton(
            onPressed: () async {
              //ToDo takip etme fonksiyonu
              userServiceController.followUser(userId);
            },
            child: Text(
              "Takip et!",
              style: GoogleFonts.lobsterTwo(
                  textStyle: TextStyle(fontSize: 12, color: Colors.black)),
            ),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: Color(0xfff6ebeb)),
          );
  }
}
