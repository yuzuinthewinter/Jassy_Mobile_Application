import 'package:flutter/cupertino.dart';

class Name {
  String firstname;
  String lastname;

  Name({this.firstname = '', this.lastname = ''});

  void updateFirstname(String firstname) {
    this.firstname = firstname;
  }

  void updateLastname(String lastname) {
    this.lastname = lastname;
  }
}

class Info {
  // Name name;
  String birthDate;
  String genre;
  String country;
  String defaultLanguage;
  String levelDefaultLanguage;
  String interestedLanguage;
  String levelInterestedLanguage;

  Info(
      {
      // required this.name,
      this.birthDate = '',
      this.genre = '',
      this.country = '',
      this.defaultLanguage = '',
      this.levelDefaultLanguage = '',
      this.interestedLanguage = '',
      this.levelInterestedLanguage = ''});
}

class UserSchema {
  String phoneNumber;
  String password;
  String role;
  String phoneOtp;

  UserSchema(
      {this.phoneNumber = '',
      this.password = '',
      this.role = '',
      this.phoneOtp = ''});
}

class Chat {
  final String name, lastMessage, image, time;
  final bool isActive;

  Chat({
    this.name = '',
    this.lastMessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false
  });
}

List chatsData = [
  Chat(
    name: "Jenny Wilson",
    lastMessage: "Hope you are doing well...",
    image: "assets/images/header_img1.png",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "assets/images/header_img1.png",
    time: "8m ago",
    isActive: true,
  ),
  Chat(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "assets/images/header_img1.png",
    time: "5d ago",
    isActive: false,
  ),
  Chat(
    name: "Jacob Jones",
    lastMessage: "You’re welcome :)",
    image: "assets/images/header_img1.png",
    time: "5d ago",
    isActive: true,
  ),
  Chat(
    name: "Albert Flores",
    lastMessage: "Thanks",
    image: "assets/images/header_img1.png",
    time: "6d ago",
    isActive: false,
  ),
  Chat(
    name: "Jenny Wilson",
    lastMessage: "Hope you are doing well...",
    image: "assets/images/header_img1.png",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "assets/images/header_img1.png",
    time: "8m ago",
    isActive: true,
  ),
  Chat(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "assets/images/header_img1.png",
    time: "5d ago",
    isActive: false,
  ),
];
