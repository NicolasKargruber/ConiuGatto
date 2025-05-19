enum VerbIrregularityFilter {
  any("Any"),
  regular('Regular'),
  irregular('Irregular'),
  highlyIrregular('Highly Irregular'),
  stemChange('Stem changing'),
  spellingChange('Spelling changing'),
  usingIsc('Using -isc-'),
  presentGerund('Irregular gerundio'),
  pastParticiple('Irregular past participle'),
  doubleAuxiliary('Double Auxiliary');

  final String label;
  const VerbIrregularityFilter(this.label);

  String get prefKey => toString();
}