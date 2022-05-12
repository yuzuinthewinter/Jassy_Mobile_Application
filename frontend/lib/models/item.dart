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

  FavMassage({
    required this.id,
    this.text = '',
  });
}
List<FavMassage> test = [
  FavMassage(id: 1, text: "sawasdee ka im thai"),
  FavMassage(id: 2, text: "sawasdee ka im thai"),
  FavMassage(id: 3, text: "sawasdee ka im thai"),
  FavMassage(id: 4, text: "sawasdee ka im thai"),
];

