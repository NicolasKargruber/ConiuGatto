enum Irregularity {
  stemChange('stem change'),
  spellingChange('spelling change'),
  usingIsc('using -isc-'),
  presentGerund('present gerund'),
  pastParticiple('past participle');

  final String jsonKey;
  const Irregularity(this.jsonKey);

  factory Irregularity.fromJson(dynamic json)
  => Irregularity.values.firstWhere((e) => e.jsonKey == json);
}