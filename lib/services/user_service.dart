import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_getx/pages/my_bottom_bar.dart';

import '../models/user_model.dart';
import '../pages/login_page.dart';

class UserService extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController adSoyadController = TextEditingController();
  TextEditingController selectedJobController = TextEditingController();
  TextEditingController hakkimdaController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (auth.currentUser != null) {
        getCurrentUserDoc();
        getAllUsers();
      }
    });
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
    rePasswordController.clear();
    adSoyadController.clear();
    selectedJobController.clear();
    hakkimdaController.clear();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> logOut() async {
    FirebaseAuth.instance.signOut();
    Get.to(LoginPage());
  }

  //kullanıcının girişini firebaseauth'ta kontrol eden fonksiyon
  Future<void> girisYap() async {
    await auth
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((kullanici) async {
      await getCurrentUserDoc(); //giriş fonksiyonu çalıştığında user bilgilerini çekme fonksiyonu çalışıyorgetCurrentUserDoc();
      await getAllUsers(); //giriş fonksiyonu çalıştığında bütün kullanıcı listesini de çekme fonksiyonunu çalıştırıyoruz.
      Get.to(BottomBarAllPages());
    });
  }

  //user kayıt fonksiyonu;
  Future<void> createUser() async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((kullanici) {
        if (kullanici.user == null) return;
        MyUser user = MyUser(
            adSoyad: adSoyadController.text,
            email: emailController.text,
            uid: kullanici.user!.uid,
            isAlani: selectedJobController.text == null
                ? 'Seçilmemiş'
                : selectedJobController.text,
            imageUrl: "",
            hakkimda:
                hakkimdaController.text == null ? '' : hakkimdaController.text,
            takipListesi: [],
            takipciListesi: []);
        FirebaseFirestore.instance
            .collection('Users')
            .doc(kullanici.user!.uid)
            .set(user.toMap());
        clearControllers();
        Get.to(LoginPage());
      });
    } on Exception catch (e) {
      if (e.toString().contains("email address is badly formatted.")) {
        Fluttertoast.showToast(
            msg: "Email adresini düzgün formatta giriniz.",
            backgroundColor: Colors.redAccent);
        return;
      }
      Fluttertoast.showToast(msg: "Mail adresi zaten kullanılıyor");
    }
  }

  //current user işlemleri;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxString adSoyad = "".obs;
  RxString imageUrl = "".obs;
  RxString hakkimda = "".obs;
  RxString isAlani = "".obs;
  RxString currentUserUid = "".obs;
  RxList<String> followerList = <String>[].obs;
  RxList<String> followList = <String>[].obs;
  RxList toDoList = [].obs;

  StreamSubscription<DocumentSnapshot>?
      userDocRef; //kullanıcı bilgilerini sürekli olarak çekmek için

  //CurrentUser bilgilerine ulaştığımız fonksiyon
  Future<void> getCurrentUserDoc() async {
    final user = FirebaseAuth.instance.currentUser;
    //User data
    userDocRef = FirebaseFirestore
        .instance //burada üstte oluşturduğumuz streamSubscription nesnesini kulanıyoruz
        .collection('Users')
        .doc(user?.uid)
        .snapshots()
        .listen((userDocSnapshot) {
      if (userDocSnapshot.exists) {
        final Map<String, dynamic> data =
            userDocSnapshot.data() as Map<String, dynamic>;

        adSoyad.value = data["adSoyad"];
        imageUrl.value = data["imageUrl"];
        hakkimda.value = data["hakkimda"];
        isAlani.value = data["isAlani"];
        currentUserUid.value = data["uid"];
        followerList.value = List<String>.from(data['takipciListesi'] ?? []);
        followList.value = List<String>.from(data['takipListesi'] ?? []);
        //ToDo todoList' çek
      }
    });
  }

  //FOTOĞRAF YÜKLEME İŞLEMLERİ
  Future<void> updateImageUrl(String imageUrl) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUserUid.value)
        .update(<String, String>{"imageUrl": imageUrl});
  }

  Future<void> uploadImageAndUpdateImageUrl() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 30);

    if (imageFile != null) {
      File file = File(imageFile.path);
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child("user_images/${currentUserUid.value}");
      UploadTask uploadTask = storageRef.putFile(file);
      try {
        await uploadTask.whenComplete(() async {
          String imageUrl = await storageRef.getDownloadURL();
          await updateImageUrl(imageUrl);
        });
      } catch (e) {
        print("Hata: $e");
      }
    }
  }

  //Tüm kullanıcıların listesini çekme;
  Stream<QuerySnapshot<Map<String, dynamic>>>? allUserListStream;

  Future<void> getAllUsers() async {
    print(currentUserUid.value);
    allUserListStream = FirebaseFirestore.instance
        .collection("Users")
        .where("uid", isNotEqualTo: currentUserUid.value)
        .snapshots();
  }

/*
  //Kullanıcıtakip etme metodu
  Future<void> followUser(String userId) async {
    //currentUser dökümanına ulaşma
    final currentUserDocRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUserUid.value);

    //takip edilen kullanıcının dökümanına ulaşma bunu card indeksi ile vericez
    final followedUserDocRef =
        FirebaseFirestore.instance.collection("Users").doc(userId);

    //burdaki işlemleri ortak bir işlemmiş gibi yapmak için batch ile bağlıyorum.
    WriteBatch batch = FirebaseFirestore.instance.batch();

    batch.update(currentUserDocRef, {
      "takipListesi": FieldValue.arrayUnion([userId])
    });

    batch.update(followedUserDocRef, {"takipciListesi": FieldValue.arrayUnion([currentUserUid.value])});

    await batch.commit();
  }

  //explore card'daki kullanıcıyı current user takip ediyor mu?
  bool isFollow(
    String userId,
  ) {
    return followList.value.contains(userId);
  }

  Future<void> unFollowUser(String userId) async {
    //currentUser dökümanına ulaşma
    final currentUserDocRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUserUid.value);

    //takipten çıkılan kullanıcının dökümanına ulaşma bunu card indeksi ile vericez
    final followedUserDocRef =
        FirebaseFirestore.instance.collection("Users").doc(userId);

    WriteBatch batch = FirebaseFirestore.instance.batch();

    batch.update(currentUserDocRef, {
      "takipListesi": FieldValue.arrayRemove([userId])
    });

    batch.update(followedUserDocRef, {
      "takipciListesi": FieldValue.arrayRemove([currentUserUid.value])
    });

    batch.commit();
  }*/
}
