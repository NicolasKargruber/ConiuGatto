import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../view_models/quiz_length_view_model.dart';
import 'counter_button.dart';


// TODO Move logic to viewModel
class QuizLengthSheet extends StatelessWidget {
  const QuizLengthSheet({super.key, required this.showQuizScreen});

  final Function(int) showQuizScreen;

  // TODO Use Navigator
  static show(BuildContext context, {required Function(int) showQuizScreen}) async {
    await showModalBottomSheet(
      context: context,
      builder: (_) {
        return ChangeNotifierProvider(
          create: (_) => QuizLengthViewModel(),
          child: QuizLengthSheet(showQuizScreen: (length) {
            Navigator.pop(context);
            showQuizScreen(length);
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<QuizLengthViewModel>();
    return Padding(
      padding: const EdgeInsets.only(bottom: AppValues.p48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.maxFinite,
            alignment: AlignmentDirectional.center,
            padding: EdgeInsets.all(AppValues.p12),
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: BorderRadius.all(Radius.circular(AppValues.r4)),
            ),
            child: Text(
              context.localization.revisionSheetTitle,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: AppValues.fs24,
                color: context.colorScheme.onPrimary,
              ),
            ),
          ),

          SizedBox(height: AppValues.s20),

          Text(context.localization.revisionSheetSubtitle,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs20),
          ),

          SizedBox(height: AppValues.s16),

          _CounterButton(),

          SizedBox(height: AppValues.s16),
          FilledButton(
            onPressed: () => showQuizScreen(viewModel.quizLength),
            child: Padding(
              padding: const EdgeInsets.all(AppValues.p12),
              child: Text(context.localization.startQuiz, style: TextStyle(fontSize: AppValues.fs16)),
            ),
          ),
        ],
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  const _CounterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<QuizLengthViewModel>();

    return CounterButton(
      value: viewModel.quizLength,
      increment: viewModel.increment,
      decrement: viewModel.decrement,
    );
  }
}
