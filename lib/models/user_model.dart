// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class MyUser {
  String adSoyad;
  String email;
  String uid;
  String isAlani;
  String imageUrl;
  String? hakkimda;
  List<String> takipListesi;
  List<String> takipciListesi;
  MyUser({
    required this.adSoyad,
    required this.email,
    required this.uid,
    required this.isAlani,
    required this.imageUrl,
    this.hakkimda,
    required this.takipListesi,
    required this.takipciListesi,
  });

  MyUser copyWith({
    String? adSoyad,
    String? email,
    String? uid,
    String? isAlani,
    String? imageUrl,
    String? hakkimda,
    List<String>? ilgiAlani,
    List<String>? takipListesi,
    List<String>? takipciListesi,
  }) {
    return MyUser(
      adSoyad: adSoyad ?? this.adSoyad,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      isAlani: isAlani ?? this.isAlani,
      imageUrl: imageUrl ?? this.imageUrl,
      hakkimda: hakkimda ?? this.hakkimda,
      takipListesi: takipListesi ?? this.takipListesi,
      takipciListesi: takipciListesi ?? this.takipciListesi,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adSoyad': adSoyad,
      'email': email,
      'uid': uid,
      'isAlani': isAlani,
      'imageUrl': imageUrl,
      'hakkimda': hakkimda,
      'takipListesi': takipListesi,
      'takipciListesi': takipciListesi,
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
  return MyUser(
    adSoyad: map['adSoyad'] as String,
    email: map['email'] as String,
    uid: map['uid'] as String,
    isAlani: map['isAlani'] as String,
    imageUrl: map['imageUrl'] as String,
    hakkimda: map['hakkimda'] != null ? map['hakkimda'] as String : null,
    takipListesi:
        List<String>.from(map['takipListesi'].map((item) => item as String)),
    takipciListesi:
        List<String>.from(map['takipciListesi'].map((item) => item as String)),
  );
}

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) =>
      MyUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyUser(adSoyad: $adSoyad, email: $email, uid: $uid, isAlani: $isAlani, imageUrl: $imageUrl, hakkimda: $hakkimda, takipListesi: $takipListesi, takipciListesi: $takipciListesi)';
  }

  @override
  bool operator ==(covariant MyUser other) {
    if (identical(this, other)) return true;

    return other.adSoyad == adSoyad &&
        other.email == email &&
        other.uid == uid &&
        other.isAlani == isAlani &&
        other.imageUrl == imageUrl &&
        other.hakkimda == hakkimda &&
        listEquals(other.takipListesi, takipListesi) &&
        listEquals(other.takipciListesi, takipciListesi);
  }

  @override
  int get hashCode {
    return adSoyad.hashCode ^
        email.hashCode ^
        uid.hashCode ^
        isAlani.hashCode ^
        imageUrl.hashCode ^
        hakkimda.hashCode ^
        takipListesi.hashCode ^
        takipciListesi.hashCode;
  }
}
