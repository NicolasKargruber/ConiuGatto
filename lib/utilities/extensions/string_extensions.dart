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