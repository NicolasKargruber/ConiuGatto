enum ItalianAuxiliary { avere('avere'), essere('essere');

  final String jsonKey;
  const ItalianAuxiliary(this.jsonKey);

  bool get requiresGenderedParticiple => this == ItalianAuxiliary.essere;
  String get label => name.toUpperCase();

  factory ItalianAuxiliary.fromJson(dynamic json)
  => ItalianAuxiliary.values.firstWhere((e) => e.jsonKey == json);
}