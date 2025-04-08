import 'package:coniugatto/models/auxiliary.dart';

import '../tense.dart';

abstract class Mood {
  abstract final String name;
  List<Tense> getTenses(Auxiliary auxiliary);
}
