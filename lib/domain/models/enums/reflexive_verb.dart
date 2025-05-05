// TODO rename to Filter
enum ReflexiveVerb {
  exclude("Exclude"), include("Include"), only("Only");

  final String label;
  const ReflexiveVerb(this.label);

  String get prefKey => toString();
}