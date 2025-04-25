import 'moods/conditional.dart';
import 'moods/imperative.dart';
import 'moods/indicative.dart';
import 'moods/subjunctive.dart';

interface class BaseVerb {
  // Moods
  final Indicative indicative;
  final Subjunctive subjunctive;
  final Conditional conditional;
  final Imperative imperative;

  BaseVerb({
    required this.indicative,
    required this.subjunctive,
    required this.conditional,
    required this.imperative,
  });
}