import 'dart:math';

extension Randomize<E> on Iterable<E> {
  static final _random = Random();
  E? get randomElementOrNull {
    if(isEmpty) return null;
    return elementAt(_random.nextInt(length));
  }
}