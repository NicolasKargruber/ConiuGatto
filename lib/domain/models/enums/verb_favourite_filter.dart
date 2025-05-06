enum VerbFavouriteFilter {
  all("All"),
  //top100("Top 100"),
  //top300("Top 300"),
  starred("Starred ⭐️");
  //custom("Choose verbs")

  final String label;
  const VerbFavouriteFilter(this.label);

  String get prefKey => toString();
}