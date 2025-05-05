import '../verb.dart';

enum VerbEndingFilter {
  all("All"), inAre("ARE"), inEre("ERE"), inIre("IRE");

  final String label;
  const VerbEndingFilter(this.label);

  String get prefKey => toString();

  // TODO Move to Extensions
  bool includesVerb(Verb verb) {
    switch (this) {
      case VerbEndingFilter.all:
        return true;
      case VerbEndingFilter.inAre:
        return verb.ending == "ARE";
      case VerbEndingFilter.inEre:
        return verb.ending == "ERE";
      case VerbEndingFilter.inIre:
        return verb.ending == "IRE";
    }
  }
}