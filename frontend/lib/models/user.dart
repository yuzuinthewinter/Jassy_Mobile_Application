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

/* chatuser for demo @deprecated */
class ChatUser {
  final int id;
  final String name, image;
  final bool isActive;

  ChatUser(
      {required this.id,
      this.name = '',
      this.image = '',
      this.isActive = false});
}
