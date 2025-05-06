enum VerbIrregularityFilter {
  any("Any"),
  regular('Regular'),
  irregular('Irregular'),
  highlyIrregular('Highly Irregular'),
  stemChange('Stem changing'),
  spellingChange('Spelling changing'),
  usingIsc('Using -isc-'),
  presentGerund('Irregular gerundio'),
  pastParticiple('Irregular past participle');

  final String label;
  const VerbIrregularityFilter(this.label);

  String get prefKey => toString();

  // TODO in CON-57
  // TODO Move to Extensions
  /*bool includesVerb(Verb verb) {
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
    }
  }*/
}