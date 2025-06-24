import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/quizzed_question.dart';
import '../../../domain/models/verb.dart';
import '../../../domain/service/history_service.dart';
import '../../../domain/service/verb_service.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../../revision/screens/revision_screen.dart';
import '../../widgets/quiz_history_count.dart';
import '../../widgets/shake_widget.dart';
import '../../widgets/solution_sheet.dart';
import '../view_models/quiz_view_model.dart';
import 'quiz_content.dart';

final _logTag = (QuizScreen).toString();

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  // TODO Use Navigator
  static show(BuildContext context, {required List<QuizzedQuestion> quizzableQuestions, required int quizLength}) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) =>
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: context.read<VerbService>()),
            ChangeNotifierProxyProvider<VerbService, QuizViewModel>(
              create: (_) => QuizViewModel(
                context.read<HistoryService>(),
                quizzableQuestions: quizzableQuestions,
                quizLength: quizLength,
              ),
              update: (_, verbService, quizViewModel) => quizViewModel!..updateVerbs(verbService.verbs),
            ),
          ],
          child: QuizScreen(),
        )),
    );
  }

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
  bool _isCheckingAnswer = false;

  _checkAnswer() async {
      if(_isCheckingAnswer) return;
      _isCheckingAnswer = true;

      // Format answer
      final answer = _textController.text.replaceAll(",", "").replaceAll(".", "").trim().toLowerCase();
      _textController.text = answer;

      // CHECK
      _viewModel.checkAnswer(answer);

      if(!_viewModel.isAnsweredCorrectly) {
        // Show WRONG animation
        debugPrint("$_logTag | Unfortunately wrong!!!");
        HapticFeedback.heavyImpact();
        _shakeKey.currentState?.shake();

        if(!_viewModel.hasTriesLeft) await _showCorrectAnswer();
      }

      if(!_viewModel.hasTriesLeft || _viewModel.isAnsweredCorrectly) {
        // Show CORRECT animation
        if(_viewModel.isAnsweredCorrectly) await Future.delayed(Duration(milliseconds: 800));

        // TODO delete
        if(_viewModel.quizLength <= _viewModel.totalQuizCount + 1) {
          if(mounted) RevisionScreen.show(context, history: _viewModel.quizHistory);
        }

        // Quiz continues
        HapticFeedback.lightImpact();
        _textController.clear();
        _viewModel.createNewQuestion();
      }

      _isCheckingAnswer = false;
  }

  // TODO Use Navigator
  _showCorrectAnswer() async {
    await showModalBottomSheet(
      context: context,
      builder: (_) {
        final viewModel = context.read<QuizViewModel>();
        return SolutionSheet(
          solution:  viewModel.currentSolution ?? '',
          reportIssue: () => viewModel.reportSolution(),
        );
      },
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<bool?> _showBackDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('End Quiz?'),
          content: const Text('Are you sure you want to exit this quiz?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(textStyle: context.textTheme.labelLarge),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(textStyle: context.textTheme.labelLarge),
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("$_logTag | build()");
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz 🕹️"),
        actionsPadding: EdgeInsets.only(right: AppValues.p16),
        actions: [_QuizHistoryCount()],
      ),
      body: PopScope<Object?>(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (didPop) return;
          final bool shouldPop = await _showBackDialog() ?? false;
          if (context.mounted && shouldPop) Navigator.pop(context);
        },
        child: Padding(
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
                  checkAnswer: _checkAnswer,
                  textController: _textController,
                  shakeKey: _shakeKey,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _QuizHistoryCount extends StatelessWidget {
  const _QuizHistoryCount({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<QuizViewModel>();
    return QuizHistoryCount(negatives: viewModel.negativeQuizCount, positives: viewModel.positiveQuizCount);
  }
}



