import 'dart:math';

extension Randomize<E> on Iterable<E> {
  static final _random = Random();
  E get randomElement => elementAt(_random.nextInt(length));

  E? get randomElementOrNull {
    if(isEmpty) return null;
    return this.randomElement;
  }
}