enum AuxiliaryFilter {
  any("Any"), avere("Avere"), essere("Essere");

  final String label;
  const AuxiliaryFilter(this.label);

  String get prefKey => toString();
}