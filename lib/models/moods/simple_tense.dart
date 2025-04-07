/// Only simple tenses WITHOUT compound tenses
enum SimpleTense {
  present('Presente'),
  imperfect('Imperfetto'),
  historicalPresentPerfect('Passato Remoto'),
  future('Futuro'),
  presentSubjunctive('Congiuntivo Presente'),
  imperfectSubjunctive('Congiuntivo Imperfetto'),
  presentConditional('Condizionale Presente');

  final String italianName;
  const SimpleTense(this.italianName);
}