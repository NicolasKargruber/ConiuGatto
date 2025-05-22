import 'package:coniugatto/data/enums/auxiliary.dart';
import 'package:coniugatto/data/enums/italian_tense.dart';
import 'package:coniugatto/data/enums/pronoun.dart';
import 'package:coniugatto/domain/models/enums/auxiliary_filter.dart';
import 'package:coniugatto/domain/models/enums/verb_ending_filter.dart';
import 'package:coniugatto/domain/models/enums/verb_favourite_filter.dart';
import 'package:coniugatto/domain/models/enums/verb_irregularity_filter.dart';
import 'package:coniugatto/domain/models/tenses/conjugation.dart';
import 'package:coniugatto/domain/models/tenses/tense.dart';
import 'package:coniugatto/domain/models/verb.dart';
import 'package:coniugatto/domain/service/history_service.dart';
import 'package:coniugatto/domain/service/shared_preference_service.dart';
import 'package:coniugatto/presentation/quiz/view_models/quiz_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSharedPreferenceService extends Mock implements SharedPreferenceService {}

class MockHistoryService extends Mock implements HistoryService {}
class MockVerb extends Mock implements Verb {}
class MockTense extends Mock implements Tense {}
class MockConjugation extends Mock implements Conjugation {}

void main() {
  late MockSharedPreferenceService mockPreferences;
  late MockHistoryService mockHistory;
  late QuizViewModel viewModel;

  setUpAll(() {
    registerFallbackValue(VerbFavouriteFilter.all);
    registerFallbackValue(AuxiliaryFilter.any);
    registerFallbackValue(VerbEndingFilter.all);
    registerFallbackValue(VerbIrregularityFilter.any);
    registerFallbackValue(ItalianTense.presentIndicative);
    registerFallbackValue(Pronoun.firstSingular);
    registerFallbackValue(MockTense());
  });

  setUp(() {
    mockPreferences = MockSharedPreferenceService();
    mockHistory = MockHistoryService();

    when(() => mockPreferences.initializationFuture)
        .thenAnswer((_) async => {});
    when(() => mockPreferences.loadVerbFavouriteFilter())
        .thenReturn(VerbFavouriteFilter.all);
    when(() => mockPreferences.loadAuxiliaryFilter())
        .thenReturn(AuxiliaryFilter.any);
    when(() => mockPreferences.loadVerbEndingFilter())
        .thenReturn(VerbEndingFilter.all);
    when(() => mockPreferences.loadVerbIrregularityFilter())
        .thenReturn(VerbIrregularityFilter.any);
    when(() => mockPreferences.loadTenses())
        .thenReturn(ItalianTense.values);
    when(() => mockPreferences.loadPronouns())
        .thenReturn(Pronoun.values);

    viewModel = QuizViewModel(mockPreferences, mockHistory);
  });

  test('should update verbs and find quizzable verbs with ALL filters active', () {
    final verb = MockVerb();
    final tense = MockTense();
    final conjugation = MockConjugation();
    when(() => verb.auxiliaries).thenReturn([Auxiliary.avere]);
    when(() => verb.getTense(any())).thenReturn((_) => tense);
    when(() => verb.italianInfinitive).thenReturn("parlare");
    when(() => tense.type).thenReturn(ItalianTense.presentIndicative);
    when(() => tense[any()]).thenReturn(conjugation);
    when(() => conjugation.italian).thenReturn("parlo");

    viewModel.updateVerbs([verb]);

    expect(viewModel.hasQuizzableQuestions, isTrue);
    expect(viewModel.currentSolution, "parlo");
  });

  test('should return no quizzable verbs when auxiliary filter excludes verb', () {
    final verb = MockVerb();
    when(() => verb.auxiliaries).thenReturn([Auxiliary.essere]);
    //when(() => verb.getTense(any())).thenReturn((aux) => ItalianConjugation(type: ItalianTense.presente, forms: {}));
    when(() => verb.italianInfinitive).thenReturn("andare");

    when(() => mockPreferences.loadAuxiliaryFilter())
        .thenReturn(AuxiliaryFilter.avere);

    viewModel.updateVerbs([verb]);

    expect(viewModel.hasQuizzableQuestions, isFalse);
  });

  test('should return no quizzable verbs when ending filter excludes verb', () {
    final verb = MockVerb();
    when(() => verb.auxiliaries).thenReturn([Auxiliary.avere]);
    when(() => verb.italianInfinitive).thenReturn("dormire");
    when(() => verb.ending).thenReturn("IRE");
    //when(() => verb.getTense(any())).thenReturn((aux) => ItalianConjugation(type: ItalianTense.presente, forms: {}));

    when(() => mockPreferences.loadVerbEndingFilter())
        .thenReturn(VerbEndingFilter.inAre);

    viewModel.updateVerbs([verb]);

    expect(viewModel.hasQuizzableQuestions, isFalse);
  });

  test('should return no quizzable verbs when irregularity filter excludes verb', () {
    final verb = MockVerb();
    when(() => verb.auxiliaries).thenReturn([Auxiliary.avere]);
    when(() => verb.isRegular).thenReturn(false);
    when(() => verb.italianInfinitive).thenReturn("venire");
    //when(() => verb.getTense(any())).thenReturn((aux) => ItalianConjugation(type: ItalianTense.presente, forms: {}));

    when(() => mockPreferences.loadVerbIrregularityFilter())
        .thenReturn(VerbIrregularityFilter.regular);

    viewModel.updateVerbs([verb]);

    expect(viewModel.hasQuizzableQuestions, isFalse);
  });
}

