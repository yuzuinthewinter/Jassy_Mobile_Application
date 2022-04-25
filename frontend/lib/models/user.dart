class NameType {
  String firstname;
  String lastname;

  NameType({
    this.firstname = '',
    this.lastname = '',
  });
}

class InfoType {
  bool isActive;
  String birthDate;
  String genre;
  String country;
  String desc;
  String faceRegPic;
  List<String> profilePic;
  List<String> chats;

  InfoType({
    this.isActive = false,
    this.birthDate = '',
    this.genre = '',
    this.country = '',
    this.desc = '',
    this.faceRegPic = '',
    this.profilePic = const [],
    this.chats = const [],
  });
}

class LanguageType {
  String defaultLanguage;
  String levelDefaultLanguage;
  String interestedLanguage;
  String levelInterestedLanguage;

  LanguageType({
    this.defaultLanguage = '',
    this.levelDefaultLanguage = '',
    this.interestedLanguage = '',
    this.levelInterestedLanguage = '',
  });
}

class Filtering {
  String langguageLevel, gender;

  Filtering({
    this.langguageLevel = '',
    this.gender = '',
  });
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

/* chatuser for demo @deprecated */
class ChatUser {
  final int id;
  final List name;
  final String image;
  final bool isActive;

  ChatUser(
      {required this.id,
      this.name = const [],
      this.image = '',
      this.isActive = false});
}

class MainUser {
  final String name, desc, image, age, time, city, country, motherLanguage, interestLanguage;

  MainUser({
    this.name = '', 
    this.desc = '', 
    this.image = '', 
    this.time = '', 
    this.city = '',
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
    time: "11:16 PM",
    city: "Bangkok",
    country: "Thailand",
    motherLanguage: "Thai",
    interestLanguage: "Korean",
    age: "22",
  ),
  MainUser(
    name: "Jujee",
    desc: "Hi im Jujee. Nice too meet you",
    image: "assets/images/jujee.jpg",
    time: "11:16 PM",
    city: "Bangkok",
    country: "Thailand",
    motherLanguage: "Thai",
    interestLanguage: "Korean",
    age: "22",
  ),MainUser(
    name: "Ammie",
    desc: "Hi im Ammie. Nice too meet you",
    image: "assets/images/user1.jpg",
    time: "11:16 PM",
    city: "Bangkok",
    country: "Thailand",
    motherLanguage: "Thai",
    interestLanguage: "Korean",
    age: "22",
  ),MainUser(
    name: "Ammie",
    desc: "Hi im Ammie. Nice too meet you",
    image: "assets/images/user2.jpg",
    time: "11:16 PM",
    city: "Bangkok",
    country: "Thailand",
    motherLanguage: "Thai",
    interestLanguage: "Korean",
    age: "22",
  ),MainUser(
    name: "Ammie",
    desc: "Hi im Ammie. Nice too meet you",
    image: "assets/images/user3.jpg",
    time: "11:16 PM",
    city: "Bangkok",
    country: "Thailand",
    motherLanguage: "Thai",
    interestLanguage: "Korean",
    age: "22",
  ),MainUser(
    name: "Ammie",
    desc: "Hi im Ammie. Nice too meet you",
    image: "assets/images/user4.jpg",
    time: "11:16 PM",
    city: "Bangkok",
    country: "Thailand",
    motherLanguage: "Thai",
    interestLanguage: "Korean",
    age: "22",
  ),MainUser(
    name: "Ammie",
    desc: "Hi im Ammie. Nice too meet you",
    image: "assets/images/user5.jpg",
    time: "11:16 PM",
    city: "Bangkok",
    country: "Thailand",
    motherLanguage: "Thai",
    interestLanguage: "Korean",
    age: "22",
  ),
];
