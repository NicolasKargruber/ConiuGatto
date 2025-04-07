import 'package:coniugatto/utilities/extensions/verb_extensions.dart';

import '../verb.dart';
import 'mood.dart';

class Subjunctive extends Mood {
  // Parent Reference
  late final Verb verb;

  // Simple Tenses - Stored in JSON
  /// Presente
  final Conjugations present; // Presente
  /// Imperfetto
  final Conjugations imperfect; // Imperfetto

  // Compound Tenses - Generated dynamically
  /// Congiuntivo Passato
  Conjugations presentPerfectSubjunctive(auxiliary) => verb.presentPerfectSubjunctive(auxiliary);

  /// Congiuntivo Trapassato
  Conjugations pastPerfectSubjunctive(auxiliary) => verb.pastPerfectSubjunctive(auxiliary);

  Subjunctive({
    required this.present,
    required this.imperfect,
  });

  factory Subjunctive.fromJson(Map<String, dynamic> json) {
    return Subjunctive(
      present: MoodExtensions.parseConjugations(json['presente']),
      imperfect: MoodExtensions.parseConjugations(json['imperfetto']),
    );
  }
}