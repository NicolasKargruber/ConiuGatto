
enum Auxiliary { avere('avere'), essere('essere');


  final String jsonKey;
  const Auxiliary(this.jsonKey);

  factory Auxiliary.fromJson(dynamic json)
  => Auxiliary.values.firstWhere((e) => e.jsonKey == json);
}