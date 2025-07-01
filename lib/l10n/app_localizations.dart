import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @tensesLabel.
  ///
  /// In en, this message translates to:
  /// **'Tenses'**
  String get tensesLabel;

  /// No description provided for @tensesAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Tenses 📊'**
  String get tensesAppTitle;

  /// No description provided for @reviewLabel.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get reviewLabel;

  /// No description provided for @reviewAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Review 🏅'**
  String get reviewAppTitle;

  /// No description provided for @verbsLabel.
  ///
  /// In en, this message translates to:
  /// **'Verbs'**
  String get verbsLabel;

  /// No description provided for @verbsAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Verbs 📚'**
  String get verbsAppTitle;

  /// No description provided for @aboutAppTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutAppTitle;

  /// No description provided for @showIntroduction.
  ///
  /// In en, this message translates to:
  /// **'Show Introduction'**
  String get showIntroduction;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @filtersAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Filters 🕹️'**
  String get filtersAppTitle;

  /// No description provided for @tenseFiltersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The following tenses will be included in your Quiz.'**
  String get tenseFiltersSubtitle;

  /// No description provided for @updateTenses.
  ///
  /// In en, this message translates to:
  /// **'Update tenses'**
  String get updateTenses;

  /// No description provided for @tensesSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose from the Tenses below'**
  String get tensesSheetSubtitle;

  /// No description provided for @verbFiltersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The following verbs will be included up in your Quiz.'**
  String get verbFiltersSubtitle;

  /// No description provided for @updateVerbs.
  ///
  /// In en, this message translates to:
  /// **'Update verbs'**
  String get updateVerbs;

  /// No description provided for @verbsSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose from the Filters below'**
  String get verbsSheetSubtitle;

  /// No description provided for @irregularityLabel.
  ///
  /// In en, this message translates to:
  /// **'Irregularity'**
  String get irregularityLabel;

  /// No description provided for @endingLabel.
  ///
  /// In en, this message translates to:
  /// **'Ending'**
  String get endingLabel;

  /// No description provided for @auxiliaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Auxiliary'**
  String get auxiliaryLabel;

  /// No description provided for @pronounsLabel.
  ///
  /// In en, this message translates to:
  /// **'Pronouns'**
  String get pronounsLabel;

  /// No description provided for @pronounFiltersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The following pronouns will be included up in your Quiz.'**
  String get pronounFiltersSubtitle;

  /// No description provided for @updatePronouns.
  ///
  /// In en, this message translates to:
  /// **'Update pronouns'**
  String get updatePronouns;

  /// No description provided for @pronounsSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose from the Pronouns below'**
  String get pronounsSheetSubtitle;

  /// No description provided for @noVerbsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No verbs available 💨'**
  String get noVerbsAvailable;

  /// No description provided for @languageLevelsTitle.
  ///
  /// In en, this message translates to:
  /// **'Language Levels'**
  String get languageLevelsTitle;

  /// No description provided for @languageLevelsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Italian tense are grouped into the following CEFR levels: A1, A2, B1, B2 and C1.'**
  String get languageLevelsSubtitle;

  /// No description provided for @languageLevelsBody.
  ///
  /// In en, this message translates to:
  /// **'After reaching fluency in the tense it will be successfully marked as fluent.'**
  String get languageLevelsBody;

  /// No description provided for @quizzingVerbsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quizzing verbs'**
  String get quizzingVerbsTitle;

  /// No description provided for @quizzingVerbsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Every quiz question consists of a VERB, TENSE (+ MOOD) and PRONOUN.'**
  String get quizzingVerbsSubtitle;

  /// No description provided for @quizzingVerbsBody.
  ///
  /// In en, this message translates to:
  /// **'In order to answer a question you must conjugate the verb accordingly.'**
  String get quizzingVerbsBody;

  /// No description provided for @starringVerbsTitle.
  ///
  /// In en, this message translates to:
  /// **'Starring verbs'**
  String get starringVerbsTitle;

  /// No description provided for @starringVerbsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'To quiz only specific verbs you can star them via the star button.'**
  String get starringVerbsSubtitle;

  /// No description provided for @starringVerbsBody.
  ///
  /// In en, this message translates to:
  /// **'Apply your \'Starred ⭐\' verbs in your quiz filters.'**
  String get starringVerbsBody;

  /// No description provided for @doubleAuxiliaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Double Auxiliary'**
  String get doubleAuxiliaryTitle;

  /// No description provided for @doubleAuxiliarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Some italian verbs can use both \nAVERE and ESSERE.'**
  String get doubleAuxiliarySubtitle;

  /// No description provided for @doubleAuxiliaryBody.
  ///
  /// In en, this message translates to:
  /// **'You can choose which auxiliary the conjugation tables will display.'**
  String get doubleAuxiliaryBody;

  /// No description provided for @reportIssueTitle.
  ///
  /// In en, this message translates to:
  /// **'Report issue'**
  String get reportIssueTitle;

  /// No description provided for @reportIssueSubtitle.
  ///
  /// In en, this message translates to:
  /// **'All conjugations have a little flag somewhere. By tapping this flag, you can report an issue.'**
  String get reportIssueSubtitle;

  /// No description provided for @reportIssueBody.
  ///
  /// In en, this message translates to:
  /// **'This helps me (the developer) out a lot!'**
  String get reportIssueBody;

  /// No description provided for @endQuizTitle.
  ///
  /// In en, this message translates to:
  /// **'End Quiz?'**
  String get endQuizTitle;

  /// No description provided for @endQuizSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit this quiz?'**
  String get endQuizSubtitle;

  /// No description provided for @quizAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Quiz 🕹️'**
  String get quizAppTitle;

  /// No description provided for @noMatchingQuestions.
  ///
  /// In en, this message translates to:
  /// **'No matching Questions available! 😭'**
  String get noMatchingQuestions;

  /// No description provided for @checkYourFiltersLabel.
  ///
  /// In en, this message translates to:
  /// **'Check your Filters in the Settings'**
  String get checkYourFiltersLabel;

  /// No description provided for @goToFilters.
  ///
  /// In en, this message translates to:
  /// **'Go to Filters'**
  String get goToFilters;

  /// No description provided for @revisionAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Revision'**
  String get revisionAppTitle;

  /// No description provided for @revisionAnswer.
  ///
  /// In en, this message translates to:
  /// **'Answer: {answer}'**
  String revisionAnswer(String answer);

  /// No description provided for @revisionSolution.
  ///
  /// In en, this message translates to:
  /// **'Solution: {solution}'**
  String revisionSolution(String solution);

  /// No description provided for @quizIncorrectLabel.
  ///
  /// In en, this message translates to:
  /// **'Quiz Incorrect Conjugations'**
  String get quizIncorrectLabel;

  /// No description provided for @tenseExample.
  ///
  /// In en, this message translates to:
  /// **'Example: {example}'**
  String tenseExample(String example);

  /// No description provided for @fluencyScoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Fluency Score:'**
  String get fluencyScoreLabel;

  /// No description provided for @lastQuizzedLabel.
  ///
  /// In en, this message translates to:
  /// **'Last time quizzed:'**
  String get lastQuizzedLabel;

  /// No description provided for @fluencyReachedLabel.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You\'re now fluent in this tense! 🎉🕺🏻'**
  String get fluencyReachedLabel;

  /// No description provided for @revisionSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Revision Quiz'**
  String get revisionSheetTitle;

  /// No description provided for @revisionSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Number of questions'**
  String get revisionSheetSubtitle;

  /// No description provided for @startQuiz.
  ///
  /// In en, this message translates to:
  /// **'Start quiz'**
  String get startQuiz;

  /// No description provided for @verbSearchbarHint.
  ///
  /// In en, this message translates to:
  /// **'Search verb ...'**
  String get verbSearchbarHint;

  /// No description provided for @noVerbFound.
  ///
  /// In en, this message translates to:
  /// **'No verb found! 🔍'**
  String get noVerbFound;

  /// No description provided for @requestVerb.
  ///
  /// In en, this message translates to:
  /// **'Request verb'**
  String get requestVerb;

  /// No description provided for @foundIssueLabel.
  ///
  /// In en, this message translates to:
  /// **'Found an issue?'**
  String get foundIssueLabel;

  /// No description provided for @reportIssue.
  ///
  /// In en, this message translates to:
  /// **'Report issue'**
  String get reportIssue;

  /// No description provided for @incorrectLabel.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get incorrectLabel;

  /// No description provided for @correctAnswerLabel.
  ///
  /// In en, this message translates to:
  /// **'Correct Answer'**
  String get correctAnswerLabel;

  /// No description provided for @incorrectAnswer.
  ///
  /// In en, this message translates to:
  /// **'❌ Wrong Answer!'**
  String get incorrectAnswer;

  /// No description provided for @blankAnswer.
  ///
  /// In en, this message translates to:
  /// **'📄 Blank Answer!'**
  String get blankAnswer;

  /// No description provided for @wrongPronounInAnswer.
  ///
  /// In en, this message translates to:
  /// **'🥸 Wrong Pronoun!'**
  String get wrongPronounInAnswer;

  /// No description provided for @missingAccentsInAnswer.
  ///
  /// In en, this message translates to:
  /// **'🎩 Almost, accents are missing ...'**
  String get missingAccentsInAnswer;

  /// No description provided for @almostCorrectAnswer.
  ///
  /// In en, this message translates to:
  /// **'🧐 There is a typo somewhere ...'**
  String get almostCorrectAnswer;

  /// No description provided for @correctAnswer.
  ///
  /// In en, this message translates to:
  /// **'✅ Correct Answer!'**
  String get correctAnswer;

  /// No description provided for @regular.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get regular;

  /// No description provided for @irregular.
  ///
  /// In en, this message translates to:
  /// **'Irregular'**
  String get irregular;

  /// No description provided for @highlyIrregular.
  ///
  /// In en, this message translates to:
  /// **'Highly irregular'**
  String get highlyIrregular;

  /// No description provided for @never.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get never;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String daysAgo(int days);

  /// No description provided for @check.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get check;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// No description provided for @unselectOrSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Un-/Select All'**
  String get unselectOrSelectAll;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
