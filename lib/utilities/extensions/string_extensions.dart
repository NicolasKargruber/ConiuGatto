import 'package:flutter/foundation.dart';

extension StringExtensions on String {
  String get last {
    if(isEmpty) return "";
    return substring(length - 1, length);
  }

  String replaceLastWith(String replacement) {
    if(isEmpty) return replacement;
    return '${substring(0, length - 1)}$replacement';
  }

  void printDifferences(String s) {
    final length = this.length > s.length ? this.length : s.length;
    for (int i = 0; i < length; i++) {
      final charA = i < this.length ? this[i] : '-';
      final charB = i < s.length ? s[i] : '-';
      if (charA != charB) {
        if (kDebugMode) print('Difference at index $i: "$charA" vs "$charB"');
      }
    }
  }
}