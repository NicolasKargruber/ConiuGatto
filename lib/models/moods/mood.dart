import '../auxiliary.dart';

import '../tenses/tense.dart';

abstract class Mood {
  abstract final String label;
  List<Tense> getTenses(Auxiliary auxiliary);
}
