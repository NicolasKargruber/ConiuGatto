// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get tensesLabel => 'Tenses';

  @override
  String get tensesAppTitle => 'Tenses 📊';

  @override
  String get reviewLabel => 'Review';

  @override
  String get reviewAppTitle => 'Review 🏅';

  @override
  String get verbsLabel => 'Verbs';

  @override
  String get verbsAppTitle => 'Verbs 📚';

  @override
  String get aboutAppTitle => 'About';

  @override
  String get showIntroduction => 'Show Introduction';

  @override
  String get filtersAppTitle => 'Filters 🕹️';

  @override
  String get tenseFiltersSubtitle =>
      'The following tenses will be included in your Quiz.';

  @override
  String get updateTenses => 'Update tenses';

  @override
  String get tensesSheetSubtitle => 'Choose from the Tenses below';

  @override
  String get verbFiltersSubtitle =>
      'The following verbs will be included up in your Quiz.';

  @override
  String get updateVerbs => 'Update verbs';

  @override
  String get verbsSheetSubtitle => 'Choose from the Filters below';

  @override
  String get irregularityLabel => 'Irregularity';

  @override
  String get endingLabel => 'Ending';

  @override
  String get auxiliaryLabel => 'Auxiliary';

  @override
  String get pronounsLabel => 'Pronouns';

  @override
  String get pronounFiltersSubtitle =>
      'The following pronouns will be included up in your Quiz.';

  @override
  String get updatePronouns => 'Update pronouns';

  @override
  String get pronounsSheetSubtitle => 'Choose from the Pronouns below';

  @override
  String get noVerbsAvailable => 'No verbs available 💨';

  @override
  String get languageLevelsTitle => 'Language Levels';

  @override
  String get languageLevelsSubtitle =>
      'Italian tense are grouped into the following CEFR levels: A1, A2, B1, B2 and C1.';

  @override
  String get languageLevelsBody =>
      'After reaching fluency in the tense it will be successfully marked as fluent.';

  @override
  String get quizzingVerbsTitle => 'Quizzing verbs';

  @override
  String get quizzingVerbsSubtitle =>
      'Every quiz question consists of a VERB, TENSE (+ MOOD) and PRONOUN.';

  @override
  String get quizzingVerbsBody =>
      'In order to answer a question you must conjugate the verb accordingly.';

  @override
  String get starringVerbsTitle => 'Starring verbs';

  @override
  String get starringVerbsSubtitle =>
      'To quiz only specific verbs you can star them via the star button.';

  @override
  String get starringVerbsBody =>
      'Apply your \'Starred ⭐\' verbs in your quiz filters.';

  @override
  String get doubleAuxiliaryTitle => 'Double Auxiliary';

  @override
  String get doubleAuxiliarySubtitle =>
      'Some italian verbs can use both \nAVERE and ESSERE.';

  @override
  String get doubleAuxiliaryBody =>
      'You can choose which auxiliary the conjugation tables will display.';

  @override
  String get reportIssueTitle => 'Report issue';

  @override
  String get reportIssueSubtitle =>
      'All conjugations have a little flag somewhere. By tapping this flag, you can report an issue.';

  @override
  String get reportIssueBody => 'This helps me (the developer) out a lot!';

  @override
  String get endQuizTitle => 'End Quiz?';

  @override
  String get endQuizSubtitle => 'Are you sure you want to exit this quiz?';

  @override
  String get quizAppTitle => 'Quiz 🕹️';

  @override
  String get noMatchingQuestions => 'No matching Questions available! 😭';

  @override
  String get checkYourFiltersLabel => 'Check your Filters in the Settings';

  @override
  String get goToFilters => 'Go to Filters';

  @override
  String get revisionAppTitle => 'Revision';

  @override
  String revisionAnswer(String answer) {
    return 'Answer: $answer';
  }

  @override
  String revisionSolution(String solution) {
    return 'Solution: $solution';
  }

  @override
  String get quizIncorrectLabel => 'Quiz Incorrect Conjugations';

  @override
  String tenseExample(String example) {
    return 'Example: $example';
  }

  @override
  String get fluencyScoreLabel => 'Fluency Score:';

  @override
  String get lastQuizzedLabel => 'Last time quizzed:';

  @override
  String get fluencyReachedLabel =>
      'Congratulations! You\'re now fluent in this tense! 🎉🕺🏻';

  @override
  String get revisionSheetTitle => 'Revision Quiz';

  @override
  String get revisionSheetSubtitle => 'Number of questions';

  @override
  String get startQuiz => 'Start quiz';

  @override
  String get verbSearchbarHint => 'Search verb ...';

  @override
  String get noVerbFound => 'No verb found! 🔍';

  @override
  String get requestVerb => 'Request verb';

  @override
  String get foundIssueLabel => 'Found an issue?';

  @override
  String get reportIssue => 'Report issue';

  @override
  String get incorrectLabel => 'Incorrect';

  @override
  String get correctAnswerLabel => 'Correct Answer';

  @override
  String get check => 'Check';

  @override
  String get back => 'Back';

  @override
  String get start => 'Start';

  @override
  String get skip => 'Skip';

  @override
  String get done => 'Done';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get selectAll => 'Select All';

  @override
  String get unselectOrSelectAll => 'Un-/Select All';
}
