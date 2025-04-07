enum Regularity { regular('regular'), irregular('irregular');

  final String jsonKey;
  const Regularity(this.jsonKey);

  factory Regularity.fromJson(dynamic json)
  => Regularity.values.firstWhere((e) => e.jsonKey == json);
}