import 'dart:math';

typedef Difference = (String original, String other, {int index});

extension StringExtensions on String {
  String get last {
    if(isEmpty) return "";
    return substring(length - 1, length);
  }

  String replaceLastWith(String replacement) {
    if(isEmpty) return replacement;
    return '${substring(0, length - 1)}$replacement';
  }

  List<Difference> diff(String s) {
    final length = this.length > s.length ? this.length : s.length;
    final differences = <Difference>[];
    for (int i = 0; i < length; i++) {
      final charA = i < this.length ? this[i] : '-';
      final charB = i < s.length ? s[i] : '-';
      if (charA != charB) {
        differences.add((charA, charB, index: i));
      }
    }
    return differences;
  }

  int levenshteinDistance(String s) {
    final matrix = List.generate(length + 1, (i) => List.filled(s.length + 1, 0));

    for (var i = 0; i <= length; i++) {
      matrix[i][0] = i;
    }
    for (var j = 0; j <= s.length; j++) {
      matrix[0][j] = j;
    }

    for (var i = 1; i <= length; i++) {
      for (var j = 1; j <= s.length; j++) {
        final cost = this[i - 1] == s[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1,       // Deletion
          matrix[i][j - 1] + 1,       // Insertion
          matrix[i - 1][j - 1] + cost // Substitution
        ].reduce(min);
      }
    }
    return matrix[length][s.length];
  }

  String removeDiacritics() {
    final withDia =    'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    final withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    String replaced = this;
    for (int i = 0; i < withDia.length; i++) {
      replaced = replaced.replaceAll(withDia[i], withoutDia[i]);
    }

    return replaced;

  }
}