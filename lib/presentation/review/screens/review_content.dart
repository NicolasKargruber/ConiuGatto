import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/answer_result.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../../../utilities/widget_factory.dart';
import '../../widgets/quiz_button.dart';
import '../../widgets/quiz_input_fields.dart';
import '../../widgets/shake_widget.dart';
import '../view_models/review_view_model.dart';

final _logTag = (QuizContent).toString();

class QuizContent extends StatelessWidget {
  const QuizContent({super.key,
    required this.onFiltersButtonPressed,
    required this.checkAnswer,
    required this.textController,
    required this.shakeKey,
  });

  final Function() onFiltersButtonPressed;
  final Function() checkAnswer;
  final TextEditingController textController;
  final GlobalKey<ShakeWidgetState> shakeKey;

  @override
  Widget build(BuildContext context) {
    debugPrint("$_logTag | build()");
    final viewModel = context.watch<ReviewViewModel>();

    return !viewModel.hasQuizzableQuestions ?
    Center(child: _NoQuestionsAvailable(onFiltersButtonPressed: onFiltersButtonPressed)) :
    Padding(
      padding: const EdgeInsets.symmetric(horizontal:  AppValues.p48, vertical: AppValues.p16),
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
                      AuxiliaryWidgetFactory.createChip(label: viewModel.currentAuxiliaryLabel ?? ''),

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
                      viewModel.currentQuestionLabel ?? "Not available",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: AppValues.fs28,
                      ),
                      maxLines: 1,
                    ),

                    SizedBox(height: AppValues.s4),

                    AutoSizeText(
                      viewModel.getCurrentTranslation(context) ?? "Not available",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: AppValues.fs20,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppValues.s64),

              TapRegion(
                onTapOutside: (PointerDownEvent event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Column(
                  children: [
                    _QuizInputFields(
                      textController: textController,
                      onSubmitted: (_) => checkAnswer(),
                      hasCorrectAnswer: viewModel.isAnsweredCorrectly,
                      answerResult: viewModel.currentAnswerResult,
                    ),

                    SizedBox(height: AppValues.s12),

                    // Check Button
                    QuizButton(
                        onPressed: checkAnswer,
                        shakeKey: shakeKey
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuizInputFields extends StatelessWidget {
  const _QuizInputFields({super.key,
    required this.textController,
    required this.onSubmitted,
    required this.hasCorrectAnswer,
    this.answerResult,
  });

  final TextEditingController textController;
  final void Function(String) onSubmitted;
  final bool hasCorrectAnswer;
  final AnswerResult? answerResult;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ReviewViewModel>();
    return QuizInputFields(
      textController: textController,
      onSubmitted: onSubmitted,
      hasCorrectAnswer: viewModel.isAnsweredCorrectly,
      answerResult: viewModel.currentAnswerResult,
    );
  }
}


class _NoQuestionsAvailable extends StatelessWidget {
  const _NoQuestionsAvailable({
    super.key,
    required this.onFiltersButtonPressed,
  });

  final Function() onFiltersButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppValues.s8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(context.localization.noMatchingQuestions,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs20)
        ),

        SizedBox(height: AppValues.s16),

        Text(context.localization.checkYourFiltersLabel),
        FilledButton.tonalIcon(
          onPressed: onFiltersButtonPressed,
          icon: Icon(Icons.edit_rounded),
          label: Padding(
            padding: const EdgeInsets.all(AppValues.p8),
            child: Text(
                context.localization.goToFilters,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs16)
            ),
          ),
        )
      ],
    );
  }
}
