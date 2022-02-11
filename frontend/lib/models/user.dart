class Name {
  String firstname;
  String lastname;

  Name(this.firstname, this.lastname);
}

class Info {
  Name name;
  String birthDate;
  String genre;
  String country;
  String defaultLanguage;
  String levelDefaultLanguage;
  String interestedLanguage;
  String levelInterestedLanguage;

  Info(
      this.name,
      this.birthDate,
      this.genre,
      this.country,
      this.defaultLanguage,
      this.levelDefaultLanguage,
      this.interestedLanguage,
      this.levelInterestedLanguage);
}

class User {
  String phoneNumber;
  String password;
  String role;
  String phoneOtp;
  Info info;

  User(this.phoneNumber, this.password, this.role, this.phoneOtp, this.info);
}
