import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/verb.dart';
import '../../../domain/service/package_info_service.dart';
import '../../../domain/service/shared_preference_service.dart';
import '../../../domain/service/verb_service.dart';
import '../../../utilities/app_values.dart';
import '../../about/screens/about_screen.dart';
import '../../settings/view_models/settings_view_model.dart';
import '../view_models/review_view_model.dart';
import '../../widgets/shake_widget.dart';
import '../widgets/quiz_history_count.dart';
import '../widgets/solution_sheet.dart';
import 'review_content.dart';
import '../../settings/screens/settings_screen.dart';

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

      _viewModel.checkAnswer(_textController.text);

      if(!_viewModel.isAnsweredCorrectly) {
        // Show WRONG animation
        debugPrint("$_logTag | Unfortunately wrong!!!");
        HapticFeedback.heavyImpact();
        _shakeKey.currentState?.shake();

        if(!_viewModel.hasTriesLeft) await _showCorrectAnswer();
      }

      if(!_viewModel.hasTriesLeft || _viewModel.isAnsweredCorrectly) {

        if(_viewModel.isAnsweredCorrectly) await Future.delayed(Duration(milliseconds: 1500));

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
        title: Text("Review 🏅"),
        actions: [
          QuizHistoryCount(),
          IconButton(
            onPressed: _showSettingsScreen, icon: Icon(Icons.edit_rounded),
            visualDensity: VisualDensity(horizontal: -1.0),
          ),
          IconButton(
            onPressed: () => AboutScreen.show(context),
            icon: Icon(Icons.settings_rounded),
            visualDensity: VisualDensity(horizontal: -4.0),),
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
