import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/verb.dart';
import '../../../domain/service/shared_preference_service.dart';
import '../../../domain/service/verb_service.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../../about/screens/about_screen.dart';
import '../../filters/screens/filters_screen.dart';
import '../../filters/view_models/filters_view_model.dart';
import '../../widgets/quiz_history_count.dart';
import '../../widgets/shake_widget.dart';
import '../../widgets/solution_sheet.dart';
import '../view_models/review_view_model.dart';
import 'review_content.dart';

final _logTag = (ReviewScreen).toString();

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {

  // ViewModel
  late final Future _loadingVerbs = context.read<VerbService>().initializationFuture;
  List<Verb> get _verbs => context.read<VerbService>().verbs;
  late final _viewModel = context.read<ReviewViewModel>();

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
        final viewModel = context.read<ReviewViewModel>();
        return SolutionSheet(
          solution:  viewModel.currentSolution ?? '',
          reportIssue: () => viewModel.reportSolution(),
        );
      },
    );
  }

  // TODO Use Navigator
  _showFiltersScreen() async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) =>
        ChangeNotifierProvider.value(
          value: context.read<VerbService>(),
          child: ChangeNotifierProxyProvider<VerbService, FiltersViewModel>(
            create: (_) => FiltersViewModel(context.read<SharedPreferenceService>()),
            update: (_, verbService, settingsViewModel) => settingsViewModel!..updateVerbs(verbService.verbs),
            child: FiltersScreen(),
          ),
        ))
    );

    if(mounted) context.read<ReviewViewModel>().updateQuiz();
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
        title: Text(context.localization.reviewAppTitle),
        actions: [
          _QuizHistoryCount(),
          IconButton(
            onPressed: _showFiltersScreen, icon: Icon(Icons.edit_rounded),
            visualDensity: VisualDensity(horizontal: -1.0),
          ),
          IconButton(
            onPressed: () => AboutScreen.show(context),
            icon: Icon(Icons.settings_rounded),
            visualDensity: VisualDensity(horizontal: -4.0),),
        ],
      ),
      body: Container(
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsets.symmetric(horizontal: AppValues.p16),
        child: FutureBuilder(
          future: _loadingVerbs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (_verbs.isEmpty) {
              return Text(context.localization.noVerbsAvailable);
            } else {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: AppValues.s480,
                ),
                child: ReviewContent(
                  onFiltersButtonPressed: _showFiltersScreen,
                  checkAnswer: _checkAnswer,
                  textController: _textController,
                  shakeKey: _shakeKey,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _QuizHistoryCount extends StatelessWidget {
  const _QuizHistoryCount({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ReviewViewModel>();
    return viewModel.hasCurrentQuestion ?
    QuizHistoryCount(negatives: viewModel.negativeQuizCount, positives: viewModel.positiveQuizCount) :
    Spacer();
  }
}
