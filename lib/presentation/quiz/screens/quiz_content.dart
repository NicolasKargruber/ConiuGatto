import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../../../utilities/widget_factory.dart';
import '../../widgets/quiz_button.dart';
import '../../widgets/quiz_input_fields.dart';
import '../../widgets/shake_widget.dart';
import '../view_models/quiz_view_model.dart';

final _logTag = (QuizContent).toString();

class QuizContent extends StatelessWidget {
  const QuizContent({super.key,
    required this.checkAnswer,
    required this.textController,
    required this.shakeKey,
  });

  final Function() checkAnswer;
  final TextEditingController textController;
  final GlobalKey<ShakeWidgetState> shakeKey;

  @override
  Widget build(BuildContext context) {
    debugPrint("$_logTag | build()");
    final viewModel = context.watch<QuizViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  AppValues.p48, vertical: AppValues.p16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          QuizCount(count: viewModel.totalQuizCount, quizLength: viewModel.quizLength),

          SizedBox(height: AppValues.s16),

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

                          SizedBox(height: AppValues.s8),

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

                    SizedBox(height: AppValues.s44),

                    TapRegion(
                      onTapOutside: (PointerDownEvent event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Column(
                        children: [
                          QuizInputFields(
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
          ),
        ],
      ),
    );
  }
}

class QuizCount extends StatelessWidget {
  const QuizCount({super.key, required this.count, required this.quizLength});

  final int count;
  final int quizLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(quizLength <= 10) AnimatedSmoothIndicator(
          activeIndex: count,
          count: quizLength,
          effect: WormEffect(
            activeDotColor: context.colorScheme.primary,
            dotColor: context.colorScheme.surfaceContainerHighest,
          ),
        )
        else Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(AppValues.r12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p16, vertical: AppValues.p8),
            child: Text("$count / $quizLength",
              style: context.textTheme.headlineSmall,
            )
        ),
      ],
    );
  }
}

