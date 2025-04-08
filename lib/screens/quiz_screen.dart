import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:coniugatto/models/auxiliary.dart';
import 'package:coniugatto/models/pronoun.dart';
import 'package:coniugatto/utilities/extensions/string_extensions.dart';
import 'package:coniugatto/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/moods/mood.dart';
import '../models/tense.dart';
import '../models/verb.dart';
import '../viewmodels/verb_manager.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future _loadingVerbs;
  Verb? currentVerb;
  Auxiliary? currentAuxiliary;
  Mood? currentMood;
  Tense? currentTense;
  Pronoun currentPronoun = Pronoun.firstSingular;

  List<Verb> get verbs => context.read<VerbViewModel>().verbs;
  int activeIndex = 0;

  final _textController = TextEditingController();

  // TODO move to VerbManager
  final _random = Random();

  final _shakeKey = GlobalKey<ShakeWidgetState>();

  _checkAnswer() {
    final String currentAnswer;
    if ((currentAuxiliary?.requiresGenderedParticiple ?? false) &&
        (currentTense?.usesPastParticiple ?? false)) {
      currentAnswer = currentPronoun.genderItalianConjugationIfPossible(
        _textController.text,
      );
    } else {
      currentAnswer = _textController.text;
    }
    debugPrint("QuizScreen | Current Answer : $currentAnswer");
    final bool areAnswersEqual =
        currentAnswer == currentTense?[currentPronoun]?.italian;
    setState(() {
      if (areAnswersEqual) {
        debugPrint("QuizScreen | Correct Answer!!!");
        activeIndex++;
        _textController.clear();
        _randomizeVerb();
      } else {
        debugPrint("QuizScreen | Unfortunately wrong!!!");
        currentAnswer.printDifferences(
          currentTense?[currentPronoun]?.italian ?? '',
        );
        _shakeKey.currentState?.shake();
      }
    });
  }

  _randomizeVerb() {
    setState(() {
      currentVerb = verbs[_random.nextInt(verbs.length)];
      currentAuxiliary =
          currentVerb?.auxiliaries[_random.nextInt(
            currentVerb!.auxiliaries.length,
          )];
      currentMood =
          currentVerb?.moods[_random.nextInt(currentVerb!.moods.length)];
      final tenses = currentMood?.getTenses(
        currentAuxiliary ?? Auxiliary.avere,
      );
      currentTense = tenses?[_random.nextInt(tenses.length)];
      currentPronoun = Pronoun.values[_random.nextInt(Pronoun.values.length)];
      debugPrint("QuizScreen | Current Verb : ${currentVerb?.infinitive}");
      debugPrint(
        "QuizScreen | Solution : (${currentPronoun.italian}) ${currentTense?[currentPronoun]?.italian}",
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _loadingVerbs = context.read<VerbViewModel>().loadVerbs();
    _loadingVerbs.then((_) {
      setState(_randomizeVerb);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz 🕹️")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: _loadingVerbs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (verbs.isEmpty) {
              return Center(child: Text('No verbs available'));
            } else {
              return Column(
                children: [
                  AnimatedSmoothIndicator(
                    activeIndex: activeIndex, // PageController
                    count: 10,
                    effect: WormEffect(), // your preferred effect
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(48.0),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AutoSizeText(
                            "${currentTense?.name} - ${currentMood?.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 24,
                            ),
                            maxLines: 1,
                          ),

                          SizedBox(height: 18),

                          AutoSizeText(
                            "${currentPronoun.italian} (${currentVerb?.infinitive})",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 28,
                            ),
                            maxLines: 1,
                          ),

                          SizedBox(height: 4),

                          Text(
                            "${currentPronoun.english} ${currentTense?[currentPronoun]?.english}",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                            ),
                          ),

                          SizedBox(height: 64),

                          TextField(
                            textAlign: TextAlign.center,
                            controller: _textController,
                            decoration: InputDecoration(
                              suffixIconConstraints: BoxConstraints(
                                maxHeight: 24,
                                maxWidth: 24,
                              ),
                              suffixIcon: IconButton.filledTonal(
                                padding: EdgeInsets.all(0.0),
                                onPressed: _textController.clear,
                                icon: Icon(Icons.clear, size: 12),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          ShakeWidget(
                            key: _shakeKey,
                            child: FilledButton(
                              onPressed: _checkAnswer,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Check",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
