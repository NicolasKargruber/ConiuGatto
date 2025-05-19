enum VerbEndingFilter {
  all("All"), inAre("-ARE"), inEre("-ERE"), inIre("-IRE");

  final String label;
  const VerbEndingFilter(this.label);

  String get prefKey => toString();
}