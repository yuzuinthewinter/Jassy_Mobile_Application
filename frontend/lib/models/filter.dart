class Filter {
  final String lang, langLV, gender;
  final List<String> rangeValues;

  Filter(
      {required this.lang,
      required this.langLV,
      required this.gender,
      required this.rangeValues});
}

class FilterIndex {
  final int langIndex, langlvIndex, genderIndex;

  FilterIndex(
      {required this.langIndex,
      required this.langlvIndex,
      required this.genderIndex});
}

