import 'pronoun.dart';

abstract class Tense {
  final Map<Pronoun, String> conjugations;

  Tense({
    required this.conjugations,
  });
}

class TenseType {
  final String jsonKey;
  final bool isCompound;

  const TenseType(this.jsonKey, this.isCompound);
}

class IndicativeTenses {
  static const presente = TenseType('presente', false);
  static const passatoProssimo = TenseType('passato_prossimo', true);
  static const imperfetto = TenseType('imperfetto', false);
  static const trapassatoProssimo = TenseType('trapassato_prossimo', true);
  static const passatoRemoto = TenseType('passato_remoto', false);
  static const trapassatoRemoto = TenseType('trapassato_remoto', true);
  static const futuroSemplice = TenseType('futuro_semplice', false);
  static const futuroAnteriore = TenseType('futuro_anteriore', true);

  static const all = [
    presente,
    passatoProssimo,
    imperfetto,
    trapassatoProssimo,
    passatoRemoto,
    trapassatoRemoto,
    futuroSemplice,
    futuroAnteriore,
  ];
}

class SubjunctiveTenses {
  static const presente = TenseType('presente', false);
  static const passato = TenseType('passato', true);
  static const imperfetto = TenseType('imperfetto', false);
  static const trapassato = TenseType('trapassato', true);

  static const all = [
    presente,
    passato,
    imperfetto,
    trapassato,
  ];
}

class ConditionalTenses {
  static const presente = TenseType('presente', false);
  static const passato = TenseType('passato', true);

  static const all = [
    presente,
    passato,
  ];
}

class ImperativeTenses {
  static const presente = TenseType('presente', false);

  static const all = [
    presente,
  ];
}