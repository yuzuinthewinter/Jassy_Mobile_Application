class Community {
  final String name, image;
  final int id, member;

  Community({
    required this.id,
    this.name = '', 
    this.image = '',
    this.member = 0,
  });
}

final Community thai = Community(
  id: 1,
  name: "Thai",
  image: "assets/images/user1.jpg",
  member: 123
);
final Community korean = Community(
  id: 2,
  name: "Korean",
  image: "assets/images/user2.jpg",
  member: 1200
);
final Community english = Community(
  id: 3,
  name: "English",
  image: "assets/images/user3.jpg",
  member: 4652
);
final Community indonesia = Community(
  id: 1,
  name: "Indonesiaaaaaaaaaaaaaa",
  image: "assets/images/user4.jpg",
  member: 321
);

class GroupActivity {
  Community groupName;
  // final String writer, news, image;
  // final List comment;
  // final int like, member;
  // final DateTime date;

  GroupActivity({
    required this.groupName,
    // this.writer = '',
    // this.news = '',
    // this.comment = const [],
    // this.image = '',
    // this.like = 0,
    // this.member = 0,
    // required this.date,
  });
}

final List<GroupActivity> groupLists = [
  GroupActivity(
    groupName: thai,
  ),
  GroupActivity(
    groupName: korean,
  ),
  GroupActivity(
    groupName: english,
  ),
  GroupActivity(
    groupName: indonesia,
  ),
];

class News {
  Community groupName;
  final String writer, news;
  final List comment, image;
  final int like;
  final DateTime date;

  News({
    required this.groupName,
    this.writer = 'Nutchapa',
    this.news = '',
    this.comment = const [],
    this.image = const [],
    this.like = 0,
    required this.date,
  });
}

List<News> newsLists = [
  News(
    writer: "Nutchapa",
    news: "อากาศที่ไทยวันนี้ดีมากค่ะ",
    comment: [],
    image: [],
    like: 100,
    groupName: thai,
    date: DateTime.now(),
  ),
  News(
    writer: "Nutchapa",
    news: "how to say hello in korean ?",
    comment: [],
    image: [],
    like: 100,
    groupName: korean,
    date: DateTime.now(),
  ),
  News(
    writer: "Nutchapa",
    news: "fuck you แปลว่าอะไรคะ",
    comment: [],
    image: [],
    like: 100,
    groupName: english,
    date: DateTime.now(),
  ),
  News(
    writer: "Nutchapa",
    news: "",
    comment: [],
    image: [],
    like: 100,
    groupName: indonesia,
    date: DateTime.now(),
  ),
  News(
    writer: "Nutchapa",
    news: "how to say Thank you in korean ?",
    comment: [],
    image: [],
    like: 100,
    groupName: korean,
    date: DateTime.now(),
  ),
  News(
    writer: "Nutchapa",
    news: "พรุ่งนี้ภาษาอังกฤษคือไรคะ",
    comment: [],
    image: [],
    like: 100,
    groupName: english,
    date: DateTime.now(),
  ),
];