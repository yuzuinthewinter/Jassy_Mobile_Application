class ItemModel {
  final String text, icon;
  late int id;

  ItemModel({
    required this.id,
    this.text = '',
    this.icon = '',
  });
}

class FavMassage {
  final String text;
  late int id;
  late bool isIndexCheck;

  FavMassage({
    required this.id,
    this.text = '',
    required this.isIndexCheck,
  });
}
List<FavMassage> test = [
  FavMassage(id: 1, text: "sawasdee ka im thai", isIndexCheck: false),
  FavMassage(id: 2, text: "sawasdee ka im thaii", isIndexCheck: true),
  FavMassage(id: 3, text: "sawasdee ka im thaiiii", isIndexCheck: false),
  FavMassage(id: 4, text: "sawasdee ka im thaiiiii", isIndexCheck: false),
];

