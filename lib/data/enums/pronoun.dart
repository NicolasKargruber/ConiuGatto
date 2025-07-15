enum Pronoun {
  firstSingular('io', 'mi'),
  secondSingular('tu', 'ti'),
  thirdSingular('lui/lei', 'si'),
  firstPlural('noi', 'ci'),
  secondPlural('voi', 'vi'),
  thirdPlural('loro', 'si');

  bool get isPlural => this == Pronoun.firstPlural || this == Pronoun.secondPlural || this == Pronoun.thirdPlural;

  String get prefKey => jsonKey;
  String get jsonKey  => italian; // => "io"
  final String italian; // => "io"
  final String reflexivePronoun; // => "mi"

  const Pronoun(this.italian, this.reflexivePronoun);

  factory Pronoun.fromJson(dynamic json)
  => Pronoun.values.firstWhere((e) => e.jsonKey == json);
}