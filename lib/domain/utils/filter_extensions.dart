import '../../data/enums/auxiliary.dart';
import '../models/enums/auxiliary_filter.dart';
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

extension AuxiliaryFilterExtensions on AuxiliaryFilter {
  bool includesVerb(Verb verb) {
    switch (this) {
      case AuxiliaryFilter.any:
        return true;
      case AuxiliaryFilter.essere:
        return verb.auxiliaries.contains(Auxiliary.essere);
      case AuxiliaryFilter.avere:
        return verb.auxiliaries.contains(Auxiliary.avere);
    }
  }
}