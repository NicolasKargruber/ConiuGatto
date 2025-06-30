enum GermanAuxiliary { haben('haben'), sein('sein');

  final String jsonKey;
  const GermanAuxiliary(this.jsonKey);

  String get label => name.toUpperCase();

  factory GermanAuxiliary.fromJson(dynamic json)
  => GermanAuxiliary.values.firstWhere((e) => e.jsonKey == json);
}