enum Regularity {
  regular('regular'),
  irregular('irregular'),
  highlyIrregular('highly irregular');

  final String jsonKey;
  const Regularity(this.jsonKey);

  bool get isRegular => this == Regularity.regular;

  factory Regularity.fromJson(dynamic json)
  => Regularity.values.firstWhere((e) => e.jsonKey == json);
}