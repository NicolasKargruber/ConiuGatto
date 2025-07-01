import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/question.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../view_models/revision_view_model.dart';

class RevisionScreen extends StatelessWidget {
  const RevisionScreen({super.key});

  // TODO Use Navigator
  static show(BuildContext context, {required List<Question> history}) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) =>
        ChangeNotifierProvider(
          create: (_) => RevisionViewModel(history),
          child: RevisionScreen(),
        ),),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RevisionViewModel>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: AppValues.p8, bottom: AppValues.p32),
        child: Column(
          children: [
            Flexible(
              child: ListView(
                children: [
                  Center(
                    child: Text(
                      context.localization.revisionAppTitle,
                      style: const TextStyle(
                        fontSize: AppValues.fs36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppValues.s12),

                  ...viewModel.questions.mapIndexed((index, question) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: AppValues.p8, horizontal: AppValues.p16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppValues.r12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppValues.p20, vertical: AppValues.p16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    question.tense.extendedLabel,
                                    style: const TextStyle(
                                      fontSize: AppValues.fs18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: AppValues.s8),
                                  Text(
                                    context.localization.revisionAnswer(question.answer??"' '"),
                                    style: TextStyle(
                                        fontSize: AppValues.fs14,
                                        color: question.isCorrect ? context.colorScheme.tertiary : context.colorScheme.error,
                                        fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: AppValues.s4),
                                  Text(
                                    context.localization.revisionSolution(question.solutionExtended ?? "' '"),
                                    style:  TextStyle(
                                      fontSize: AppValues.fs14,
                                      color: context.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppValues.s16),
                            SizedBox(
                              width: AppValues.s32,
                              child: CircleAvatar(
                                backgroundColor: context.colorScheme.surfaceContainerHighest,
                                child: Text("${index+1}", style: TextStyle(fontSize: AppValues.fs16)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            SizedBox(height: AppValues.s20),

            FilledButton.tonalIcon(
              icon: const Icon(Icons.exit_to_app_rounded),
              onPressed: () => Navigator.of(context)..pop()..pop(),
              label: Text(context.localization.back),
            ),
          ],
        ),
      ),
    );
  }
}
