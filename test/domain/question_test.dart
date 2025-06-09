import 'package:coniugatto/domain/models/tenses/conjugation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:coniugatto/data/enums/auxiliary.dart';
import 'package:coniugatto/data/enums/pronoun.dart';
import 'package:coniugatto/domain/models/answer_result.dart';
import 'package:coniugatto/domain/models/question.dart';
import 'package:coniugatto/domain/models/verb.dart';
import 'package:coniugatto/domain/models/tenses/tense.dart';

// === MOCKS ===
class MockVerb extends Mock implements Verb {}
class MockTense extends Mock implements Tense {}
class MockConjugation extends Mock implements Conjugation {}

void main() {
  late MockVerb verb;
  late MockTense tense;

  setUp(() {
    verb = MockVerb();
    tense = MockTense();

    // Default mock values
    when(() => verb.italianInfinitive).thenReturn("andare");
    when(() => verb.isDoubleAuxiliary).thenReturn(false);
    when(() => tense.extendedLabel).thenReturn("Presente");
    when(() => tense.usesPastParticiple).thenReturn(false);
    when(() => tense.conjugations).thenReturn({
      for (final p in Pronoun.values) p: null,
    });
  });

  group('Question model', () {
    test('isCorrect returns true if answer matches solution', () {
      final pronoun = Pronoun.firstSingular;
      final conjugation = MockConjugation();
      when(() => tense[pronoun]).thenReturn(conjugation);
      when(() => conjugation.italian).thenReturn("vado");

      final question = Question(
        verb: verb,
        auxiliary: Auxiliary.avere,
        tense: tense,
        pronoun: pronoun,
      );

      final result = question.checkAnswer("vado");

      expect(result, AnswerResult.correct);
      expect(question.answer, "vado");
      expect(question.isCorrect, isTrue);
    });

    test('isCorrect returns true if answer matches pronoun + solution', () {
      final pronoun = Pronoun.firstSingular;
      final conjugation = MockConjugation();
      when(() => tense[pronoun]).thenReturn(conjugation);
      when(() => conjugation.italian).thenReturn("vado");

      final question = Question(
        verb: verb,
        auxiliary: Auxiliary.avere,
        tense: tense,
        pronoun: pronoun,
      );

      final result = question.checkAnswer("io vado");

      expect(result, AnswerResult.correct);
      expect(question.answer, "vado");
      expect(question.isCorrect, isTrue);
    });

    test('isCorrect returns true if answer matches solution and usesPastParticiple', () {
      final pronoun = Pronoun.thirdSingular;
      final conjugation = MockConjugation();
      when(() => tense[pronoun]).thenReturn(conjugation);
      when(() => tense.usesPastParticiple).thenReturn(true);
      when(() => conjugation.italian).thenReturn("è andato/a");

      final question = Question(
        verb: verb,
        auxiliary: Auxiliary.essere,
        tense: tense,
        pronoun: pronoun,
      );

      final result = question.checkAnswer("lei è andata");

      expect(result, AnswerResult.correct);
      expect(question.answer, "è andato/a");
      expect(question.isCorrect, isTrue);
    });

    test('returns wrongPronoun when correct verb is used but wrong pronoun is present', () {
      final pronoun = Pronoun.firstSingular;
      final conjugation = MockConjugation();
      when(() => tense[pronoun]).thenReturn(conjugation);
      when(() => conjugation.italian).thenReturn("vado");

      final question = Question(
        verb: verb,
        auxiliary: Auxiliary.avere,
        tense: tense,
        pronoun: pronoun,
      );

      final result = question.checkAnswer("tu vado");

      expect(result, AnswerResult.wrongPronoun);
      expect(question.answer, "tu vado"); // Stored with pronoun
    });

    test('returns wrongPronoun when correct pronoun is used but wrong verb is gendered', () {
      final pronoun = Pronoun.thirdSingular;
      final conjugation = MockConjugation();
      when(() => tense[pronoun]).thenReturn(conjugation);
      when(() => tense.usesPastParticiple).thenReturn(true);
      when(() => conjugation.italian).thenReturn("è andato/a");

      final question = Question(
        verb: verb,
        auxiliary: Auxiliary.essere,
        tense: tense,
        pronoun: pronoun,
      );

      final result = question.checkAnswer("lui è andata");

      expect(result, AnswerResult.wrongPronoun);
      expect(question.answer, "lui è andato/a"); // Stored with pronoun
    });

    test('returns incorrect when answer + pronoun are incorrect', () {
      final pronoun = Pronoun.thirdSingular;
      final conjugation = MockConjugation();
      when(() => tense[pronoun]).thenReturn(conjugation);
      when(() => tense.usesPastParticiple).thenReturn(true);
      when(() => conjugation.italian).thenReturn("è andato/a");

      final question = Question(
        verb: verb,
        auxiliary: Auxiliary.essere,
        tense: tense,
        pronoun: pronoun,
      );

      final result = question.checkAnswer("lui è andatii");

      expect(result, AnswerResult.incorrect);
      expect(question.triesLeft, equals(0));
      expect(question.answer, "è andatii"); // Stored with pronoun
    });

    test('returns missingAccents when accents are missing', () {
      final pronoun = Pronoun.firstSingular;
      final conjugation = MockConjugation();
      when(() => tense[pronoun]).thenReturn(conjugation);
      when(() => conjugation.italian).thenReturn("andrò");

      final question = Question(
        verb: verb,
        auxiliary: Auxiliary.avere,
        tense: tense,
        pronoun: pronoun,
      );

      final result = question.checkAnswer("andro");

      expect(result, AnswerResult.missingAccents);
    });

    test('returns almostCorrect when answer is 1 letter off', () {
      final pronoun = Pronoun.firstSingular;
      final conjugation = MockConjugation();
      when(() => tense[pronoun]).thenReturn(conjugation);
      when(() => conjugation.italian).thenReturn("vado");

      final question = Question(
        verb: verb,
        auxiliary: Auxiliary.avere,
        tense: tense,
        pronoun: pronoun,
      );

      final result = question.checkAnswer("vadoe");

      expect(result, AnswerResult.almostCorrect);
    });

    test('returns incorrect after max tries are used', () {
      final pronoun = Pronoun.firstSingular;
      final conjugation = MockConjugation();
      when(() => tense[pronoun]).thenReturn(conjugation);
      when(() => conjugation.italian).thenReturn("vado");

      final question = Question(
        verb: verb,
        auxiliary: Auxiliary.avere,
        tense: tense,
        pronoun: pronoun,
      );

      question.checkAnswer("wrong1");
      question.checkAnswer("wrong2");
      final result = question.checkAnswer("still wrong");

      expect(result, AnswerResult.incorrect);
      expect(question.triesLeft, equals(0));
    });

    test('solutionExtended returns full formatted solution', () {
      final pronoun = Pronoun.firstSingular;
      final conjugation = MockConjugation();
      when(() => tense[pronoun]).thenReturn(conjugation);
      when(() => conjugation.italian).thenReturn("vado");

      final question = Question(
        verb: verb,
        auxiliary: Auxiliary.avere,
        tense: tense,
        pronoun: pronoun,
      );

      expect(question.solutionExtended, equals("(io) vado"));
    });
  });
}
