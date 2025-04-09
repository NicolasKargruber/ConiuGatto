import 'dart:math';

extension Randomize on Iterable {
  static final _random = Random();
  get randomElementOrNull {
    if(isEmpty) return null;
    return elementAtOrNull(_random.nextInt(length));
  }
}