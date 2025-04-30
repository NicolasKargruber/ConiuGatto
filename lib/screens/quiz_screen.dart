import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/app_values.dart';
import '../models/verb.dart';
import '../view_models/quiz_view_model.dart';
import '../view_models/verb_view_model.dart';
import '../widgets/quiz_content.dart';
import '../widgets/shake_widget.dart';
import '../widgets/show_solution_sheet.dart';
import 'settings_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final _logTag = (QuizScreen).toString();

  // ViewModel
  late final Future _loadingVerbs = context.read<VerbViewModel>().initializationFuture;
  List<Verb> get _verbs => context.read<VerbViewModel>().verbs;
  late final _viewModel = context.read<QuizViewModel>();

  // UI Stuff
  final _textController = TextEditingController();
  final _shakeKey = GlobalKey<ShakeWidgetState>();

  _checkAnswer() async {
      _viewModel.checkAnswer(_textController.text);

      if(!(_viewModel.currentAnswerResult?.isCorrect ?? false)) {
        // Show WRONG animation
        debugPrint("$_logTag | Unfortunately wrong!!!");
        _shakeKey.currentState?.shake();

        if(!_viewModel.hasTriesLeft) await _showCorrectAnswer();
      }

      if(!_viewModel.hasTriesLeft) {
        _textController.clear();
        _viewModel.createNewQuizItem();
      }
  }

  // TODO Use Navigator
  _showCorrectAnswer() async {
    await showModalBottomSheet(
      context: context,
      builder: (_) {
        final solution = context.read<QuizViewModel>().currentSolution;
        return ShowSolutionSheet(solution: solution);
      },
    );
  }

  // TODO Use Navigator
  _showSettingsScreen() async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) =>
        ChangeNotifierProvider.value(
          value: context.read<VerbViewModel>(),
          child: SettingsScreen(),
        ))
    );

    // TODO only update if new prefs come in
    if(mounted) context.read<QuizViewModel>().updateQuizzable();
    if(mounted) context.read<QuizViewModel>().createNewQuizItem();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("$_logTag | build()");
    final viewModel = context.read<QuizViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz 🕹️"),
        actions: [
          QuizHistoryCount(),
          IconButton(onPressed: _showSettingsScreen, icon: Icon(Icons.settings_rounded)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.p16),
        child: FutureBuilder(
          future: _loadingVerbs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (_verbs.isEmpty) {
              return Center(child: Text('No verbs available 💨'));
            } else {
              return QuizContent(
                onSettingsButtonPressed: _showSettingsScreen,
                checkAnswer: _checkAnswer,
                textController: _textController,
                shakeKey: _shakeKey,
              );
            }
          },
        ),
      ),
    );
  }
}

class QuizHistoryCount extends StatelessWidget {
  const QuizHistoryCount({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<QuizViewModel>();
    return viewModel.hasQuizzableItems ? Row(
      children: [
        Text("${viewModel.negativeQuizCount}",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs16)
        ),
        SizedBox(width: AppValues.s2),
        Text("❌"),
        SizedBox(width: AppValues.s8),
        Text("${viewModel.positiveQuizCount}",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs16)
        ),
        SizedBox(width: AppValues.s2),
        Text("✓", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w800, fontSize: AppValues.fs20)),
      ],
    ) : Spacer();
  }
}
