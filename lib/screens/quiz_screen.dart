import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../data/app_values.dart';
import '../models/verb.dart';
import '../utilities/extensions/build_context_extensions.dart';
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
  List<Verb> get _verbs => context.read<VerbViewModel>().verbs;
  late final _viewModel = context.read<QuizViewModel>();

  // UI Stuff
  final _textController = TextEditingController();
  final _shakeKey = GlobalKey<ShakeWidgetState>();

  _checkAnswer() {
    setState(() async {
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
    });
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
          padding: const EdgeInsets.only(bottom: AppValues.p48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(AppValues.p12),
                child: Text(
                  "Correct answer",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: AppValues.fs20,
                  ),
                ),
              ),

              IntrinsicWidth(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(AppValues.r12)),
                  ),
                  padding: EdgeInsets.all(AppValues.p12),
                  child: Text(
                    solution ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.fs28,
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
    if(mounted) context.read<QuizViewModel>().createNewQuizItem();
  }

  @override
  void initState() {
    super.initState();
    _loadingVerbs = context.read<VerbViewModel>().initializationFuture;
    _loadingVerbs.then((_) {
      if(mounted) context.read<QuizViewModel>().createNewQuizItem();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<QuizViewModel>();

    return Scaffold(
      appBar: _buildAppBar(),
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
            } else if(!viewModel.hasQuizzableItems) {
              return Center(child: _buildNoTensesAvailableContent());
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal:  AppValues.p48, vertical: AppValues.p16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedSmoothIndicator(
                      activeIndex: viewModel.totalQuizCount, // PageController
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
                          
                              SizedBox(height: AppValues.s64),

                              // Answer Text Field
                              _buildTextField(),

                              if(_viewModel.currentAnswerResult case var result?)
                                Text(result.message),
                          
                              SizedBox(height: AppValues.s4),
                          
                              // Accents Buttons
                              _buildAccentButtons(),
                          
                              SizedBox(height: AppValues.s12),
                          
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
        if(_viewModel.hasQuizzableItems) ...[
          Text("${_viewModel.negativeQuizCount}",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs16)
          ),
          SizedBox(width: AppValues.s2),
          Text("❌"),
          SizedBox(width: AppValues.s8),
          Text("${_viewModel.positiveQuizCount}",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs16)
          ),
          SizedBox(width: AppValues.s2),
          Text("✓", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w800, fontSize: AppValues.fs20)),
        ],
        IconButton(onPressed: _showSettingsScreen, icon: Icon(Icons.settings_rounded)),
      ],
    );
  }

  _buildNoTensesAvailableContent(){
    return Column(
      spacing: AppValues.s8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('No Quizzable Tenses available! 😭',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs20)
        ),

        SizedBox(height: AppValues.s16),

        Text('Check your Filters in the Settings'),
        FilledButton.tonalIcon(
          onPressed: _showSettingsScreen,
          icon: Icon(Icons.settings_rounded),
          label: Padding(
            padding: const EdgeInsets.all(AppValues.p8),
            child: Text(
                "Go to Settings",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs16)
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
        padding: const EdgeInsets.all(AppValues.p8),
        child: Text("Check", style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs24),
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
          maxHeight: AppValues.s24,
          maxWidth: AppValues.s24,
        ),
        suffixIcon: IconButton.filled(
          padding: EdgeInsets.all(AppValues.p0),
          onPressed: _textController.clear,
          icon: Icon(Icons.clear, size: AppValues.s12, color: context.colorScheme.onPrimary),
        ),
      ),
    );
  }
}
