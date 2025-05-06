import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../domain/models/enums/mood.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../view_models/verb_detail_view_model.dart';
import '../widgets/conjugation_table.dart';

final _logTag = (VerbDetailScreen).toString();

class VerbDetailScreen extends StatelessWidget {
  const VerbDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("$_logTag | build()");
    final viewModel = context.watch<VerbDetailViewModel>();
    
    return Scaffold(
      appBar: AppBar(title: Text(viewModel.italianInfinitive)),
      body: Padding(
        padding: const EdgeInsets.all(AppValues.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppValues.p8),
              child: Text(viewModel.italianInfinitive, style: TextStyle(fontSize: AppValues.fs24, fontWeight: FontWeight.bold )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppValues.p8),
              child: Text(viewModel.translation, style: TextStyle(fontSize: AppValues.fs16,)),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppValues.p8),
              child: ButtonFactory.createButton(viewModel.isRegular),
            ),

            // TODO Handle it's own state
            if(viewModel.isDoubleAuxiliary)
              Container(
                padding: const EdgeInsets.all(AppValues.p8),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Auxiliary:", style: TextStyle(fontSize: AppValues.fs16)),

                    SizedBox(width: AppValues.s12),

                    ToggleSwitch(
                      initialLabelIndex: viewModel.selectedAuxiliaryIndex,
                      activeBgColors: [[context.colorScheme.tertiary],[context.colorScheme.tertiary]],
                      inactiveBgColor: context.colorScheme.surfaceContainerHighest,
                      activeFgColor: context.colorScheme.onTertiary,
                      labels: viewModel.auxiliaryLabels,
                      onToggle: viewModel.selectAuxiliaryAtIndex,
                    ),
                  ],
                ),
              ),

            SizedBox(height: AppValues.s8),

            Divider(),

            Expanded(
              child: ListView(
                children: [
                  // INDICATIVO
                  Padding(
                    padding: const EdgeInsets.all(AppValues.p4),
                    child: Column(
                      spacing: AppValues.s16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Mood.indicative.label, style: TextStyle(fontSize: AppValues.fs18, fontWeight: FontWeight.bold)),
                        ConjugationTable(tenses: viewModel.indicativeTenses),
                      ],
                    ),
                  ),

                  Divider(height: AppValues.s36),

                  // CONGIUNTIVO
                  Padding(
                    padding: const EdgeInsets.all(AppValues.p4),
                    child: Column(
                      spacing: AppValues.s16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Mood.subjunctive.label, style: TextStyle(fontSize: AppValues.fs18, fontWeight: FontWeight.bold)),
                        ConjugationTable(tenses: viewModel.subjunctiveTenses),
                      ],
                    ),
                  ),

                  Divider(height: AppValues.s36),

                  // CONDIZIONALE
                  Padding(
                    padding: const EdgeInsets.all(AppValues.p4),
                    child: Column(
                      spacing: AppValues.s16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Mood.conditional.label, style: TextStyle(fontSize: AppValues.fs18, fontWeight: FontWeight.bold)),
                        ConjugationTable(tenses: viewModel.conditionalTenses),
                      ],
                    ),
                  ),

                  Divider(height: AppValues.s36),

                  // IMPERATIVO
                  Padding(
                    padding: const EdgeInsets.all(AppValues.p4),
                    child: Column(
                      spacing: AppValues.s16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Mood.imperative.label, style: TextStyle(fontSize: AppValues.fs18, fontWeight: FontWeight.bold)),
                        ConjugationTable(tenses: viewModel.imperativeTenses),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonFactory {
  static Widget createButton(bool isRegular) {
    if (isRegular) {
      return FilledButton(onPressed: (){}, child: Text("Regular"));
    } else {
      return FilledButton.tonal(onPressed: (){}, child: Text("Irregular"));
    }
  }
}
