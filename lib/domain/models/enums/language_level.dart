import '../../../data/enums/italian_tense.dart';

enum LanguageLevel {
  a1,
  a2,
  b1,
  b2,
  c1;
  //c2;

  String get label => name.toUpperCase();
  String get prefKey => toString();
}