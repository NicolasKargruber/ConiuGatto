import '../models/enums/verb_ending_filter.dart';
import '../models/verb.dart';

extension VerbEndingFilterExtensions on VerbEndingFilter {
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