import 'conditional.dart';
import 'subjunctive.dart';
import 'imperative.dart';
import 'indicative.dart';

class Moods {
  final Indicative indicative; // Indicativo
  final Subjunctive subjunctive; // Congiuntivo
  final Conditional conditional; // Condizionale
  final Imperative imperative; // Imperativo

  Moods({
    required this.indicative,
    required this.subjunctive,
    required this.conditional,
    required this.imperative,
  });

  factory Moods.fromJson(Map<String, dynamic> json) {
    return Moods(
      indicative: Indicative.fromJson(json['indicativo']),
      subjunctive: Subjunctive.fromJson(json['congiuntivo']),
      conditional: Conditional.fromJson(json['condizionale']),
      imperative: Imperative.fromJson(json['imperativo']),
    );
  }
}