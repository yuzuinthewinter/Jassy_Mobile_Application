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

class ChatUser {
  final int id;
  final String name, image;
  final bool isActive;

  ChatUser({
    required this.id,
    this.name = '',
    this.image = '',
    this.isActive = false
  });
}

class MainUser {
  final String name, desc, image, age,time, country, motherLanguage, interestLanguage;

  MainUser({
    this.name = '', 
    this.desc = '', 
    this.image = '', 
    this.time = '', 
    this.country = '', 
    this.motherLanguage = '', 
    this.interestLanguage = '', 
    this.age= ''
  });
}

List<MainUser> dataLists = [
  MainUser(
    name: "Ammie",
    desc: "Hi im Ammie. Nice too meet you",
    image: "assets/images/ammie.jpg",
    time: "",
    country: "Thailand",
    motherLanguage: "Thai",
    interestLanguage: "Korean",
    age: "22",
  ),
  MainUser(
    name: "Jujee",
    desc: "Hi im Jujee. Nice too meet you",
    image: "assets/images/jujee.jpg",
    time: "",
    country: "Thailand",
    motherLanguage: "Thai",
    interestLanguage: "Korean",
    age: "22",
  ),MainUser(
    name: "Ammie",
    desc: "Hi im Ammie. Nice too meet you",
    image: "assets/images/ammie.jpg",
    time: "",
    country: "Thailand",
    motherLanguage: "Thai",
    interestLanguage: "Korean",
    age: "22",
  ),MainUser(
    name: "Ammie",
    desc: "Hi im Ammie. Nice too meet you",
    image: "assets/images/ammie.jpg",
    time: "",
    country: "Thailand",
    motherLanguage: "Thai",
    interestLanguage: "Korean",
    age: "22",
  ),MainUser(
    name: "Ammie",
    desc: "Hi im Ammie. Nice too meet you",
    image: "assets/images/ammie.jpg",
    time: "",
    country: "Thailand",
    motherLanguage: "Thai",
    interestLanguage: "Korean",
    age: "22",
  ),MainUser(
    name: "Ammie",
    desc: "Hi im Ammie. Nice too meet you",
    image: "assets/images/ammie.jpg",
    time: "",
    country: "Thailand",
    motherLanguage: "Thai",
    interestLanguage: "Korean",
    age: "22",
  ),MainUser(
    name: "Ammie",
    desc: "Hi im Ammie. Nice too meet you",
    image: "assets/images/ammie.jpg",
    time: "",
    country: "Thailand",
    motherLanguage: "Thai",
    interestLanguage: "Korean",
    age: "22",
  ),
];
