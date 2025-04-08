import 'package:coniugatto/models/auxiliary.dart';

import '../tenses/tense.dart';

abstract class Mood {
  abstract final String label;
  List<Tense> getTenses(Auxiliary auxiliary);
}
