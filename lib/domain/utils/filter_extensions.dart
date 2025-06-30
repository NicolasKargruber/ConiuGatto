import '../../data/enums/italian_auxiliary.dart';
import '../../data/enums/irregularity.dart';
import '../../data/enums/regularity.dart';
import '../models/enums/auxiliary_filter.dart';
import '../models/enums/verb_ending_filter.dart';
import '../models/enums/verb_irregularity_filter.dart';
import '../models/verb.dart';
import 'verb_extensions.dart';

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
        return verb.auxiliaries.contains(ItalianAuxiliary.essere);
      case AuxiliaryFilter.avere:
        return verb.auxiliaries.contains(ItalianAuxiliary.avere);
    }
  }
}

extension VerbIrregularityFilterExtensions on VerbIrregularityFilter {
  bool includesVerb(Verb verb) {
    switch (this) {
      case VerbIrregularityFilter.any:
        return true;
      case VerbIrregularityFilter.regular:
        return verb.isRegular;
      case VerbIrregularityFilter.irregular:
        return verb.regularity == Regularity.irregular;
      case VerbIrregularityFilter.highlyIrregular:
        return verb.regularity == Regularity.highlyIrregular;
      case VerbIrregularityFilter.stemChange:
        return verb.irregularities.contains(Irregularity.stemChange);
      case VerbIrregularityFilter.spellingChange:
        return verb.irregularities.contains(Irregularity.spellingChange);
      case VerbIrregularityFilter.usingIsc:
        return verb.irregularities.contains(Irregularity.usingIsc);
      case VerbIrregularityFilter.presentGerund:
        return verb.hasIrregularGerund;
      case VerbIrregularityFilter.pastParticiple:
        return verb.hasIrregularParticiple;
        case VerbIrregularityFilter.doubleAuxiliary:
        return verb.isDoubleAuxiliary;
    }
  }
}