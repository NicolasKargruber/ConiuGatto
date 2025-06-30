// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get tensesLabel => 'Zeiten';

  @override
  String get tensesAppTitle => 'Zeiten 📊';

  @override
  String get reviewLabel => 'Review';

  @override
  String get reviewAppTitle => 'Review 🏅';

  @override
  String get verbsLabel => 'Verben';

  @override
  String get verbsAppTitle => 'Verben 📚';

  @override
  String get aboutAppTitle => 'Über';

  @override
  String get showIntroduction => 'Einführung anzeigen';

  @override
  String get filtersAppTitle => 'Filter 🕹️';

  @override
  String get tenseFiltersSubtitle =>
      'Die folgenden Zeiten werden im Quiz verwendet.';

  @override
  String get updateTenses => 'Zeiten ändern';

  @override
  String get tensesSheetSubtitle => 'Wähle aus den folgenden Zeiten';

  @override
  String get verbFiltersSubtitle =>
      'Die folgenden Verben werden im Quiz verwendet.';

  @override
  String get updateVerbs => 'Verben ändern';

  @override
  String get verbsSheetSubtitle => 'Wähle aus den folgenden Filtern';

  @override
  String get irregularityLabel => 'Unregelmäßigkeit';

  @override
  String get endingLabel => 'Endung';

  @override
  String get auxiliaryLabel => 'Hilfsverb';

  @override
  String get pronounsLabel => 'Pronomen';

  @override
  String get pronounFiltersSubtitle =>
      'Die folgenden Pronomen werden im Quiz verwendet.';

  @override
  String get updatePronouns => 'Pronomen ändern';

  @override
  String get pronounsSheetSubtitle => 'Wähle aus den folgenden Pronomen';

  @override
  String get noVerbsAvailable => 'Keine Verben verfügbar 💨';

  @override
  String get languageLevelsTitle => 'Sprachniveaus';

  @override
  String get languageLevelsSubtitle =>
      'Italienische Zeiten sind in\nfolgende GER-Niveaus kategorisiert:\nA1, A2, B1, B2 und C1.';

  @override
  String get languageLevelsBody =>
      'Sobald du eine Zeit fließend beherrschst, wird sie als gemeistert markiert.';

  @override
  String get quizzingVerbsTitle => 'Verben abfragen';

  @override
  String get quizzingVerbsSubtitle =>
      'Jede Quizfrage besteht aus einem VERB, einer ZEIT (+ MODUS) und einem PRONOMEN.';

  @override
  String get quizzingVerbsBody =>
      'Um eine Frage zu beantworten, musst du das Verb entsprechend konjugieren.';

  @override
  String get starringVerbsTitle => 'Verben favorisieren';

  @override
  String get starringVerbsSubtitle =>
      'Um nur bestimmte Verben abzufragen, kannst du sie mit dem Stern markieren.';

  @override
  String get starringVerbsBody =>
      'Wende deine \'Markierten ⭐\' Verben in den Quiz-Filtern an.';

  @override
  String get doubleAuxiliaryTitle => 'Doppelte Hilfsverben';

  @override
  String get doubleAuxiliarySubtitle =>
      'Einige italienische Verben können sowohl \nAVERE als auch ESSERE verwenden.';

  @override
  String get doubleAuxiliaryBody =>
      'Du kannst wählen, welches Hilfsverb in den Konjugationstabellen angezeigt wird.';

  @override
  String get reportIssueTitle => 'Problem melden';

  @override
  String get reportIssueSubtitle =>
      'Alle Konjugationen haben irgendwo eine kleine Flagge. Tippe sie an, um ein Problem zu melden.';

  @override
  String get reportIssueBody => 'Das hilft mir (dem Entwickler) sehr!';

  @override
  String get endQuizTitle => 'Quiz beenden?';

  @override
  String get endQuizSubtitle => 'Möchtest du dieses Quiz wirklich beenden?';

  @override
  String get quizAppTitle => 'Quiz 🕹️';

  @override
  String get noMatchingQuestions => 'Keine passenden Fragen verfügbar! 😭';

  @override
  String get checkYourFiltersLabel =>
      'Überprüfe deine Filter in den Einstellungen';

  @override
  String get goToFilters => 'Zu den Filtern';

  @override
  String get revisionAppTitle => 'Zusammenfassung️';

  @override
  String revisionAnswer(String answer) {
    return 'Antwort: $answer';
  }

  @override
  String revisionSolution(String solution) {
    return 'Lösung: $solution';
  }

  @override
  String get quizIncorrectLabel => 'Falsche Konjugationen wiederholen';

  @override
  String tenseExample(String example) {
    return 'Beispiel: $example';
  }

  @override
  String get fluencyScoreLabel => 'Sprachkompetenz:';

  @override
  String get lastQuizzedLabel => 'Zuletzt abgefragt:';

  @override
  String get fluencyReachedLabel =>
      'Glückwunsch! Du beherrschst diese Zeitform fließend! 🎉🕺🏻';

  @override
  String get revisionSheetTitle => 'Wiederholungs-Quiz';

  @override
  String get revisionSheetSubtitle => 'Anzahl der Fragen';

  @override
  String get startQuiz => 'Quiz starten';

  @override
  String get verbSearchbarHint => 'Verb suchen ...';

  @override
  String get noVerbFound => 'Kein Verb gefunden! 🔍';

  @override
  String get requestVerb => 'Verb anfragen';

  @override
  String get foundIssueLabel => 'Problem gefunden?';

  @override
  String get reportIssue => 'Problem melden';

  @override
  String get incorrectLabel => 'Falsch';

  @override
  String get correctAnswerLabel => 'Richtige Antwort';

  @override
  String get check => 'Prüfen';

  @override
  String get back => 'Zurück';

  @override
  String get start => 'Start';

  @override
  String get skip => 'Überspringen';

  @override
  String get done => 'Fertig';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get selectAll => 'Alle auswählen';

  @override
  String get unselectOrSelectAll => 'Alle ab-/auswählen';
}
