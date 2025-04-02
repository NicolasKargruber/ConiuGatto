/// Only simple tenses WITHOUT compound tenses
enum BaseTense {
  present('Presente'),
  imperfect('Imperfetto'),
  historicalPresentPerfect('Passato Remoto'),
  future('Futuro'),
  presentSubjunctive('Congiuntivo Presente'),
  imperfectSubjunctive('Congiuntivo Imperfetto'),
  presentConditional('Condizionale Presente');

  final String italianName;
  const BaseTense(this.italianName);
}