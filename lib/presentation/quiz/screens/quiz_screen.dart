import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/verb.dart';
import '../../../domain/service/shared_preference_service.dart';
import '../../../domain/service/verb_service.dart';
import '../../../utilities/app_values.dart';
import '../../settings/view_models/settings_view_model.dart';
import '../view_models/quiz_view_model.dart';
import '../../widgets/shake_widget.dart';
import '../widgets/quiz_history_count.dart';
import '../widgets/show_solution_sheet.dart';
import 'quiz_content.dart';
import '../../settings/screens/settings_screen.dart';

final _logTag = (QuizScreen).toString();

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  // ViewModel
  late final Future _loadingVerbs = context.read<VerbService>().initializationFuture;
  List<Verb> get _verbs => context.read<VerbService>().verbs;
  late final _viewModel = context.read<QuizViewModel>();

  // UI Stuff
  final _textController = TextEditingController();
  final _shakeKey = GlobalKey<ShakeWidgetState>();

  _checkAnswer() async {
      _viewModel.checkAnswer(_textController.text);

      if(!_viewModel.isAnsweredCorrectly) {
        // Show WRONG animation
        debugPrint("$_logTag | Unfortunately wrong!!!");
        _shakeKey.currentState?.shake();

        if(!_viewModel.hasTriesLeft) await _showCorrectAnswer();
      }

      if(!_viewModel.hasTriesLeft || _viewModel.isAnsweredCorrectly) {
        _textController.clear();
        _viewModel.createNewQuestion();
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
          value: context.read<VerbService>(),
          child: ChangeNotifierProxyProvider<VerbService, SettingsViewModel>(
            create: (_) => SettingsViewModel(context.read<SharedPreferenceService>()),
            update: (_, verbService, settingsViewModel) => settingsViewModel!..updateVerbs(verbService.verbs),
            child: SettingsScreen(),
          ),
        ))
    );

    if(mounted) context.read<QuizViewModel>().updateQuiz();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("$_logTag | build()");
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
