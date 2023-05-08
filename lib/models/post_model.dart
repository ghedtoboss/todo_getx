// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class MyPost {
  String id;
  String title;
  String content;
  String author;
  bool isFinished = false;
  Map<String, String> comments;
  List<String> likes = [];
  String? date;
  MyPost({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.isFinished,
    required this.comments,
    required this.likes,
    this.date,
  });

  MyPost copyWith({
    String? id,
    String? title,
    String? content,
    String? author,
    bool? isFinished,
    Map<String, String>? comments,
    List<String>? likes,
    String? date,
  }) {
    return MyPost(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      author: author ?? this.author,
      isFinished: isFinished ?? this.isFinished,
      comments: comments ?? this.comments,
      likes: likes ?? this.likes,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'isFinished': isFinished,
      'comments': comments,
      'likes': likes,
      'date': date,
    };
  }

  factory MyPost.fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> commentsMap = map['comments'] as Map<String, dynamic>;
    Map<String, String> comments = commentsMap
        .map((key, value) => MapEntry<String, String>(key, value as String));

    List<dynamic> likesList = map['likes'] as List<dynamic>;
    List<String> likes = likesList.cast<String>();

    return MyPost(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      author: map['author'] as String,
      isFinished: map['isFinished'] as bool,
      comments: comments,
      likes: likes,
      date: map['date'] != null ? map['date'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyPost.fromJson(String source) =>
      MyPost.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyPost(id: $id, title: $title, content: $content, author: $author, isFinished: $isFinished, comments: $comments, likes: $likes, date: $date)';
  }

  @override
  bool operator ==(covariant MyPost other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.content == content &&
        other.author == author &&
        other.isFinished == isFinished &&
        mapEquals(other.comments, comments) &&
        listEquals(other.likes, likes) &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        author.hashCode ^
        isFinished.hashCode ^
        comments.hashCode ^
        likes.hashCode ^
        date.hashCode;
  }
}
