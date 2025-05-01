enum Mood {
  indicative("Indicativo"),
  subjunctive("Congiuntivo"),
  conditional("Condizionale"),
  imperative("Imperativo");

  final String label;
  String get jsonKey => name;
  const Mood(this.label);
}
