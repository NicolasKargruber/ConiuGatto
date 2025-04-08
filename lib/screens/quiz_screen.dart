import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/verb.dart';
import '../view_models/quiz_view_model.dart';
import '../view_models/verb_view_model.dart';
import '../widgets/quiz_content.dart';
import '../widgets/shake_widget.dart';
import 'settings_screen.dart';

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

  _showSettingsScreen() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
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
      appBar: AppBar(
        title: Text("Quiz 🕹️"),
        actions: [IconButton(onPressed: _showSettingsScreen, icon: Icon(Icons.settings_rounded))],
      ),
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
              return Center(child: Text('No verbs available 💨'));
            } else if(!context.read<QuizViewModel>().hasQuizzableTenses) {
              return Center(child: Column(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No Quizzable Tenses available! 😭',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),),

                  SizedBox(height: 16),

                  Text('Check your Filters in the Settings'),
                  FilledButton.tonalIcon(
                    onPressed: _showSettingsScreen,
                    icon: Icon(Icons.settings_rounded),
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Go to Settings",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                    ),
                  )
                ],
              ));
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
