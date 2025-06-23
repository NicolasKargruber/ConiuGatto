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
                      "Revision",
                      style: const TextStyle(
                        fontSize: AppValues.fs36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppValues.s12),

                  ...viewModel.questions.map((question) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: AppValues.p8, horizontal: AppValues.p16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppValues.r12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppValues.p24, vertical: AppValues.p16),
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
                              "Answer: ${question.answer??' '}",
                              style: TextStyle(
                                  fontSize: AppValues.fs14,
                                  color: question.isCorrect ? context.colorScheme.tertiary : context.colorScheme.error,
                                  fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: AppValues.s4),
                            Text(
                              "Solution: ${question.solutionExtended}",
                              style:  TextStyle(
                                fontSize: AppValues.fs14,
                                color: context.colorScheme.onSurfaceVariant,
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
              label: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
