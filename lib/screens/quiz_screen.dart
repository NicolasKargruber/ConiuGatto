import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/answer_result.dart';
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
  final _logTag = (QuizScreen).toString();
  
  // ViewModel
  late Future _loadingVerbs;
  List<Verb> get verbs => context.read<VerbViewModel>().verbs;

  // TODO Move to viewModel
  // Answer Count
  int triesLeft = 2;
  int correctAnswerCount = 0;
  int wrongAnswerCount = 0;

  // UI Stuff
  int activeIndex = 0;
  final _textController = TextEditingController();
  final _shakeKey = GlobalKey<ShakeWidgetState>();

  AnswerResult get answerResult => context.read<QuizViewModel>().isAnswerCorrect(_textController.text);

  _checkAnswer()  {
    setState(() {
      switch (answerResult) {
        case AnswerResult.correct:
          debugPrint("$_logTag | Correct Answer!!!");
          correctAnswerCount++;
          _showNextQuestion();
          return;
        case AnswerResult.almostCorrect:
          triesLeft--;
          break;
        case AnswerResult.missingAccents:
          triesLeft--;
          break;
        case AnswerResult.incorrect:
          triesLeft-=2;
          break;
      }

      // Show WRONG animation
      debugPrint("$_logTag | Unfortunately wrong!!!");
      _shakeKey.currentState?.shake();

    });

    // After 2 tries => Show next question
    if (triesLeft <= 0) {
      setState(() async {
        await _showCorrectAnswer();
        wrongAnswerCount++;
        _showNextQuestion();
      });
    }
  }

  _showNextQuestion() {
    activeIndex++;
    triesLeft = 2;
    _textController.clear();
    context.read<QuizViewModel>().createQuizItem();
  }

  void _addLetterAtSelection(String letter) {
    final selection = _textController.selection;
    final text = _textController.text;

    // Handle text replacement when there's a selection
    if (selection.isValid && !selection.isCollapsed) {
      final start = selection.start;
      final end = selection.end;
      _textController.text = text.replaceRange(start, end, letter);
      _textController.selection = TextSelection.collapsed(offset: start + letter.length);
    }
    // Handle normal insertion at cursor position
    else {
      final cursorPos = selection.base.offset;
      _textController.text = text.replaceRange(cursorPos, cursorPos, letter);
      _textController.selection = TextSelection.collapsed(offset: cursorPos + letter.length);
    }

    debugPrint("$_logTag | ${selection.isCollapsed ? 'Added' : 'Replaced'} '$letter' in answer");
  }

  // TODO Move to separate View => CON-45
  Future _showCorrectAnswer() async {
    await showModalBottomSheet(
      context: context,
      builder: (_) {
        final solution = context.read<QuizViewModel>().currentSolution;
        return Padding(
          padding: const EdgeInsets.only(bottom: 48.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(12),
                child: Text(
                  "Correct answer",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),

              IntrinsicWidth(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Text(
                    solution ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        color: Colors.green.shade700
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _showSettingsScreen() async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) =>
        ChangeNotifierProvider.value(
          value: context.read<VerbViewModel>(),
          child: SettingsScreen(),
        ))
    );
    if(mounted) context.read<QuizViewModel>().createQuizItem();
  }

  @override
  void initState() {
    super.initState();
    _loadingVerbs = context.read<VerbViewModel>().initializationFuture;
    _loadingVerbs.then((_) {
      if(mounted) context.read<QuizViewModel>().createQuizItem();
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
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder(
          future: _loadingVerbs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (verbs.isEmpty) {
              return Center(child: Text('No verbs available 💨'));
            } else if(!context.watch<QuizViewModel>().hasQuizzableItems) {
              return Center(child: _buildNoTensesAvailableContent());
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal:  48.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedSmoothIndicator(
                      activeIndex: activeIndex, // PageController
                      count: 10,
                      effect: WormEffect(), // your preferred effect
                    ),

                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          clipBehavior: Clip.none,
                          child: Column(
                            children: [
                              QuizContent(),
                          
                              SizedBox(height: 64),

                              // Answer Text Field
                              _buildTextField(),

                              if(triesLeft < 2 && !answerResult.isCorrect)
                                Text(answerResult.message),
                          
                              SizedBox(height: 4),
                          
                              // Accents Buttons
                              _buildAccentButtons(),
                          
                              SizedBox(height: 12),
                          
                              // Check Button
                              ShakeWidget(
                                key: _shakeKey,
                                child: _buildCheckButton(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // Helper Method
  _buildAppBar(){
    return AppBar(
      title: Text("Quiz 🕹️"),
      actions: [
        if(context.watch<QuizViewModel>().hasQuizzableItems) ...[
          Text("$wrongAnswerCount",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)
          ),
          SizedBox(width: 2),
          Text("❌"),
          SizedBox(width: 8),
          Text("$correctAnswerCount",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)
          ),
          SizedBox(width: 2),
          Text("✓", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w800, fontSize: 20)),
        ],
        IconButton(onPressed: _showSettingsScreen, icon: Icon(Icons.settings_rounded)),
      ],
    );
  }

  _buildNoTensesAvailableContent(){
    return Column(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('No Quizzable Tenses available! 😭',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)
        ),

        SizedBox(height: 16),

        Text('Check your Filters in the Settings'),
        FilledButton.tonalIcon(
          onPressed: _showSettingsScreen,
          icon: Icon(Icons.settings_rounded),
          label: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Go to Settings",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)
            ),
          ),
        )
      ],
    );
  }

  // Helper Method
  _buildCheckButton(){
    return FilledButton(
      onPressed: _checkAnswer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Check", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
        ),
      ),
    );
  }

  // Helper Method
  _buildAccentButtons(){
    return Wrap(children: ["è", "à", "ò", "é"]
        .map((letter) => ActionChip(
      label: Text(letter),
      onPressed: () => _addLetterAtSelection(letter),
    )).toList());
  }

  // Helper Method
  _buildTextField(){
    return TextField(
      textAlign: TextAlign.center,
      controller: _textController,
      onSubmitted: (_) => _checkAnswer(),
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
    );
  }
}
