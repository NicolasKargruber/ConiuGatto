import 'package:coniugatto/view_models/quiz_view_model.dart';
import 'package:coniugatto/widgets/quiz_content.dart';
import 'package:coniugatto/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/verb.dart';
import '../view_models/verb_view_model.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future _loadingVerbs;
  List<Verb> get verbs => context.read<VerbViewModel>().verbs;

  // UI Stuff
  int activeIndex = 0;
  final _textController = TextEditingController();
  final _shakeKey = GlobalKey<ShakeWidgetState>();

  bool get areAnswersEqual => context.read<QuizViewModel>().areAnswersEqual(_textController.text);

  _checkAnswer() {
    setState(() {
      if (areAnswersEqual) {
        debugPrint("QuizScreen | Correct Answer!!!");
        activeIndex++;
        _textController.clear();
        context.read<QuizViewModel>().randomizeVerb();
      } else {
        debugPrint("QuizScreen | Unfortunately wrong!!!");
        context.read<QuizViewModel>().printDifferences();
        _shakeKey.currentState?.shake();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadingVerbs = context.read<VerbViewModel>().initializationFuture;
    _loadingVerbs.then((_) {
      if(mounted) context.read<QuizViewModel>().randomizeVerb();
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

                  QuizContent(),

                  SizedBox(height: 64),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  48.0),
                    child: TextField(
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
