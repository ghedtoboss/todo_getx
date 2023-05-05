import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/pages/explore_page.dart';
import 'package:todo_getx/pages/home_page.dart';

import '../pages/profil_page.dart';

class BottomBarController extends GetxController {
  RxInt pageIndex = 0.obs;

  final List<Widget>pages = [HomePage(), ExplorePage(), ProfilPage(),].obs;
}
