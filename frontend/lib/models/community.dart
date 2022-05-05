import 'package:flutter/material.dart';

class Community {
  final String name, image;
  final int member;

  Community({
    this.name = '', 
    this.image = '',
    this.member = 0,
  });
}

List<Community> communityLists = [
  Community(
    name: "Thai",
    image: "assets/images/user1.jpg",
    member: 123
  ),
  Community(
    name: "Korean",
    image: "assets/images/user2.jpg",
    member: 1200
  ),
  Community(
    name: "English",
    image: "assets/images/user3.jpg",
    member: 4652
  ),
  Community(
    name: "Indonesiaaaaaaaaaaaaaa",
    image: "assets/images/user4.jpg",
    member: 321
  ),
];

class News {
  final String writer, news, comment, image, groupName;
  // final List<String> comm;
  final int like;
  // final DateTime date;

  News({
    this.writer = '',
    this.news = '',
    this.comment = '',
    this.image = '',
    this.like = 0,
    this.groupName = '',
    // required this.date,
    // this.comm = [],
  });
}

List<News> newsLists = [
  News(
    writer: "",
    news: "",
    comment: "",
    image: "",
    like: 100,
    groupName: "",
  ),
  News(
    writer: "",
    news: "",
    comment: "",
    image: "",
    like: 100,
    groupName: "",
  ),
  News(
    writer: "",
    news: "",
    comment: "",
    image: "",
    like: 100,
    groupName: "",
  ),
  News(
    writer: "",
    news: "",
    comment: "",
    image: "",
    like: 100,
    groupName: "",
  ),
  News(
    writer: "",
    news: "",
    comment: "",
    image: "",
    like: 100,
    groupName: "",
  ),
  News(
    writer: "",
    news: "",
    comment: "",
    image: "",
    like: 100,
    groupName: "",
  ),
];