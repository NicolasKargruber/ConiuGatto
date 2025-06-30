import 'package:coniugatto/data/enums/italian_auxiliary.dart';
import 'package:coniugatto/data/enums/italian_tense.dart';
import 'package:coniugatto/data/enums/pronoun.dart';
import 'package:coniugatto/domain/models/question.dart';
import 'package:coniugatto/domain/models/quizzed_question.dart';
import 'package:coniugatto/domain/models/tenses/conjugation.dart';
import 'package:coniugatto/domain/models/tenses/tense.dart';
import 'package:coniugatto/domain/models/verb.dart';
import 'package:coniugatto/domain/service/history_service.dart';
import 'package:coniugatto/presentation/quiz/view_models/quiz_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHistoryService extends Mock implements HistoryService {}
class MockVerb extends Mock implements Verb {}
class MockTense extends Mock implements Tense {}
class MockConjugation extends Mock implements Conjugation {}
class MockQuizzedQuestion extends Mock implements QuizzedQuestion {}
class FakeQuestion extends Fake implements Question {}

void main() {
  late MockHistoryService mockHistoryService;

  setUp(() {
    mockHistoryService = MockHistoryService();

    registerFallbackValue(ItalianTense.presentIndicative);
    registerFallbackValue(Pronoun.firstSingular);
    registerFallbackValue(FakeQuestion());

    when(() => mockHistoryService.addQuestion(any())).thenAnswer((_) async => {});
  });

  group('QuizViewModel', () {
    test('initializes and shuffles questions', () async {
      final verb = MockVerb();
      when(() => verb.id).thenReturn('andare');
      when(() => verb.italianInfinitive).thenReturn('andare');
      final tense = MockTense();
      when(() => verb.getTense(any())).thenReturn((_) => tense);
      final conjugation = MockConjugation();
      when(() => tense[any()]).thenReturn(conjugation);
      when(() => conjugation.italian).thenReturn('andare');

      final quizzedQuestion = MockQuizzedQuestion();
      when(() => quizzedQuestion.verbID).thenReturn('andare');
      when(() => quizzedQuestion.pronoun).thenReturn(Pronoun.firstSingular);
      when(() => quizzedQuestion.auxiliary).thenReturn(ItalianAuxiliary.avere);
      when(() => quizzedQuestion.tense).thenReturn(ItalianTense.presentIndicative);

      final viewModel = QuizViewModel(
        mockHistoryService,
        quizzableQuestions: [quizzedQuestion],
        quizLength: 1,
      );

      await viewModel.updateVerbs([verb]);

      expect(viewModel.totalQuizCount, 0);
      expect(viewModel.hasCurrentQuestion, isTrue);
    });


    test('initializes and shuffles questions', () async {
      final verb = MockVerb();
      when(() => verb.id).thenReturn('andare');
      when(() => verb.italianInfinitive).thenReturn('andare');
      final tense = MockTense();
      when(() => verb.getTense(any())).thenReturn((_) => tense);
      final conjugation = MockConjugation();
      when(() => tense[any()]).thenReturn(conjugation);
      when(() => conjugation.italian).thenReturn('andare');

      final quizzedQuestion = MockQuizzedQuestion();
      when(() => quizzedQuestion.verbID).thenReturn('andare');
      when(() => quizzedQuestion.pronoun).thenReturn(Pronoun.firstSingular);
      when(() => quizzedQuestion.auxiliary).thenReturn(ItalianAuxiliary.avere);
      when(() => quizzedQuestion.tense).thenReturn(ItalianTense.presentIndicative);

      final viewModel = QuizViewModel(
        mockHistoryService,
        quizzableQuestions: [quizzedQuestion],
        quizLength: 2,
      );

      await viewModel.updateVerbs([verb]);

      expect(viewModel.totalQuizCount, 0);
      expect(viewModel.hasCurrentQuestion, isTrue);

      viewModel.createNewQuestion();

      expect(viewModel.totalQuizCount, 1);
      expect(viewModel.hasCurrentQuestion, isTrue);
    });

    test('updates verbs and creates quiz when different list is provided', () async {
      final verb = MockVerb();
      when(() => verb.id).thenReturn('parlare');
      when(() => verb.italianInfinitive).thenReturn('parlare');
      final tense = MockTense();
      when(() => verb.getTense(any())).thenReturn((_) => tense);
      final conjugation = MockConjugation();
      when(() => tense[any()]).thenReturn(conjugation);
      when(() => conjugation.italian).thenReturn('parlato');

      final quizzedQuestion = MockQuizzedQuestion();
      when(() => quizzedQuestion.verbID).thenReturn('parlare');
      when(() => quizzedQuestion.pronoun).thenReturn(Pronoun.firstSingular);
      when(() => quizzedQuestion.auxiliary).thenReturn(ItalianAuxiliary.avere);
      when(() => quizzedQuestion.tense).thenReturn(ItalianTense.presentPerfectIndicative);

      final viewModel = QuizViewModel(
        mockHistoryService,
        quizzableQuestions: [quizzedQuestion],
        quizLength: 1,
      );

      await viewModel.updateVerbs([verb]);

      expect(viewModel.hasCurrentQuestion, isTrue);
      expect(viewModel.totalQuizCount, 0);
    });

    test('checkAnswer sets result correctly', () async {
      final verb = MockVerb();
      when(() => verb.id).thenReturn('andare');
      when(() => verb.italianInfinitive).thenReturn('andare');
      final tense = MockTense();
      when(() => verb.getTense(any())).thenReturn((_) => tense);
      final conjugation = MockConjugation();
      when(() => tense[any()]).thenReturn(conjugation);
      when(() => conjugation.italian).thenReturn('sono andato');

      final quizzedQuestion = MockQuizzedQuestion();
      when(() => quizzedQuestion.verbID).thenReturn('andare');
      when(() => quizzedQuestion.pronoun).thenReturn(Pronoun.firstSingular);
      when(() => quizzedQuestion.auxiliary).thenReturn(ItalianAuxiliary.avere);
      when(() => quizzedQuestion.tense).thenReturn(ItalianTense.presentPerfectIndicative);

      final viewModel = QuizViewModel(
        mockHistoryService,
        quizzableQuestions: [quizzedQuestion],
        quizLength: 1,
      );

      await viewModel.updateVerbs([verb]);

      final current = viewModel.currentSolution;
      expect(current, isNotNull);

      viewModel.checkAnswer(current!);
      expect(viewModel.hasCorrectAnswer, isTrue);
    });

    test('tries to skip same question twice in a row', () async {
      final verb = MockVerb();
      when(() => verb.id).thenReturn('fare');
      when(() => verb.italianInfinitive).thenReturn('fare');
      final tense = MockTense();
      when(() => verb.getTense(any())).thenReturn((_) => tense);
      final conjugation = MockConjugation();
      when(() => tense[any()]).thenReturn(conjugation);
      when(() => conjugation.italian).thenReturn('ho fatto');

      final quizzedQuestion = MockQuizzedQuestion();
      when(() => quizzedQuestion.verbID).thenReturn('fare');
      when(() => quizzedQuestion.pronoun).thenReturn(Pronoun.firstSingular);
      when(() => quizzedQuestion.auxiliary).thenReturn(ItalianAuxiliary.avere);
      when(() => quizzedQuestion.tense).thenReturn(ItalianTense.presentPerfectIndicative);

      final viewModel = QuizViewModel(
        mockHistoryService,
        quizzableQuestions: [quizzedQuestion],
        quizLength: 2,
      );

      await viewModel.updateVerbs([verb]);
      final resultBefore = viewModel.currentSolution;
      verify(viewModel.nextQuestion).called;

      // Update again with same verb
      viewModel.createNewQuestion();
      final resultAfter = viewModel.currentSolution;

      verify(viewModel.nextQuestion).called(2);
      expect(resultBefore, resultAfter);
    });
  });
}


