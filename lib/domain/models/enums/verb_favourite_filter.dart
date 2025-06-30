enum VerbFavouriteFilter {
  all("All"),
  top25("Top 25"),
  top50("Top 50"),
  top100("Top 100"),
  starred("Starred ⭐️");
  //custom("Choose verbs")

  final String label;
  const VerbFavouriteFilter(this.label);

  String get prefKey => toString();
}