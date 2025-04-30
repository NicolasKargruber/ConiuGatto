import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../data/app_values.dart';
import '../view_models/quiz_view_model.dart';
import '../widgets/quiz_input_fields.dart';
import '../widgets/shake_widget.dart';
import '../widgets/shakeable_check_button.dart';

final _logTag = (QuizContent).toString();

class QuizContent extends StatelessWidget {
  const QuizContent({
    super.key,
    required this.onSettingsButtonPressed,
    required this.checkAnswer,
    required this.textController,
    required this.shakeKey,
  });

  final Function() onSettingsButtonPressed;
  final Function() checkAnswer;
  final TextEditingController textController;
  final GlobalKey<ShakeWidgetState> shakeKey;

  @override
  Widget build(BuildContext context) {
    debugPrint("$_logTag | build()");
    final viewModel = context.watch<QuizViewModel>();

    return !viewModel.hasQuizzableItems ? Center(child: _buildNoTensesAvailable()) : Padding(
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
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if(viewModel.isDoubleAuxiliary)
                            Chip(label: Text("${viewModel.currentAuxiliaryLabel}")),
                          SizedBox(height: AppValues.s4),
                          AutoSizeText(
                            viewModel.currentTitle ?? "Not available",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: AppValues.fs24,
                            ),
                            maxLines: 1,
                          ),

                          SizedBox(height: AppValues.s18),

                          AutoSizeText(
                            viewModel.currentQuestion ?? "Not available",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: AppValues.fs28,
                            ),
                            maxLines: 1,
                          ),

                          SizedBox(height: AppValues.s4),

                          Text(
                            viewModel.currentTranslation ?? "Not available",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: AppValues.fs20,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: AppValues.s64),

                    QuizInputFields(
                      textController: textController,
                      onSubmitted: (_) => checkAnswer(),
                    ),

                    SizedBox(height: AppValues.s12),

                    // Check Button
                    ShakeableCheckButton(
                        onPressed: checkAnswer,
                        shakeKey: shakeKey
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

  _buildNoTensesAvailable(){
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
          onPressed: onSettingsButtonPressed,
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
}
