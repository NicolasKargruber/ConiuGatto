import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/enums/mood.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/widget_factory.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../view_models/verb_detail_view_model.dart';
import '../widgets/conjugation_table.dart';

class VerbDetailScreen extends StatelessWidget {
  const VerbDetailScreen({super.key});

  static final _logTag = (VerbDetailScreen).toString();

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                  ],
                ),

                StarWidgetFactory.createSelectableIconButton(
                  isStarred: viewModel.isStarred,
                  onPressed: () => viewModel.updateStarred(!viewModel.isStarred),
                ),
              ],
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppValues.p8),
              child: ButtonFactory.createFilledButton(
                  tonal: !viewModel.isRegular,
                  label: viewModel.isRegular ? "Regular" : "Irregular",
              ),
            ),

            if(viewModel.isDoubleAuxiliary)
              Center(
                child: AuxiliaryToggleButtons(
                  selectedAuxiliaryIndex: viewModel.selectedAuxiliaryIndex,
                  auxiliaryLabels: viewModel.auxiliaryLabels,
                  onToggle: viewModel.selectAuxiliaryAtIndex,
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

class AuxiliaryToggleButtons extends StatelessWidget {
  const AuxiliaryToggleButtons({super.key,
    required this.selectedAuxiliaryIndex,
    required this.auxiliaryLabels,
    required this.onToggle,
  });

  final int selectedAuxiliaryIndex;
  final List<String> auxiliaryLabels;
  final Function(int?) onToggle;

  @override
  Widget build(BuildContext context) {
    final List<bool> selectedAuxiliaries = auxiliaryLabels.map((e) => false).toList();
    selectedAuxiliaries[selectedAuxiliaryIndex] = true;
    return ToggleButtons(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedBorderColor: Colors.green.shade700,
      selectedColor: Colors.white,
      fillColor: Colors.green.shade200,
      color: Colors.green.shade400,
      constraints: const BoxConstraints(minHeight: AppValues.s40, minWidth: AppValues.s80),
      onPressed: onToggle,
      isSelected: selectedAuxiliaries,
      children: auxiliaryLabels.map((label) => Text(label)).toList(),
    );
  }
}


