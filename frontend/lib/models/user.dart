class Name {
  String firstname;
  String lastname;

  Name({this.firstname = '', this.lastname = ''});

  void updateFirstname (String firstname) {
    this.firstname = firstname;
  }

  void updateLastname (String lastname) {
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

  Info({
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

  UserSchema({this.phoneNumber = '', this.password = '', this.role = '', this.phoneOtp = ''});
}
