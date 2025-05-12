enum Auxiliary { avere('avere'), essere('essere');

  final String jsonKey;
  const Auxiliary(this.jsonKey);

  bool get requiresGenderedParticiple => this == Auxiliary.essere;
  String get label => name.toUpperCase();

  factory Auxiliary.fromJson(dynamic json)
  => Auxiliary.values.firstWhere((e) => e.jsonKey == json);
}