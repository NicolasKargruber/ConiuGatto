import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/enums/italian_tense.dart';
import '../../../domain/models/enums/mood.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../view_models/settings_view_model.dart';

class ChooseTensesSheet extends StatelessWidget {
  const ChooseTensesSheet({super.key});

  static final String _logTag = (ChooseTensesSheet).toString();

  @override
  Widget build(BuildContext context) {
    debugPrint("$_logTag | build()");
    final viewModel = context.read<SettingsViewModel>();

    onSelectTense(bool selected, {required ItalianTense tense}) {
      if(selected) { viewModel.addTenseFilter(tense); }
      else { viewModel.removeTenseFilter(tense); }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppValues.p4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(AppValues.p12),
            child: Text(
              "Choose from the Tenses below",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: AppValues.fs18,
              ),
            ),
          ),

          MoodSection(
              label: Mood.indicative.label,
              italianTenses: ItalianTense.indicativeTenses,
              onSelectedTense: onSelectTense,
              isSelected: viewModel.isTenseSelected,
          ),

          MoodSection(
              label: Mood.conditional.label,
              italianTenses: ItalianTense.conditionalTenses,
            onSelectedTense: onSelectTense,
              isSelected: viewModel.isTenseSelected,
          ),

          MoodSection(
              label: Mood.subjunctive.label,
              italianTenses: ItalianTense.subjunctiveTenses,
            onSelectedTense: onSelectTense,
              isSelected: viewModel.isTenseSelected,
          ),

          MoodSection(
              label: Mood.imperative.label,
              italianTenses: ItalianTense.imperativeTenses,
            onSelectedTense: onSelectTense,
              isSelected: viewModel.isTenseSelected,
          ),

          SizedBox(height: AppValues.s24),
        ],
      ),
    );
  }
}

class MoodSection extends StatelessWidget {
  static final String _logTag = (MoodSection).toString();

  const MoodSection({super.key,
    required this.label,
    required this.italianTenses,
    required this.onSelectedTense,
    required this.isSelected,
  });

  final String label;
  final List<ItalianTense> italianTenses;
  final Function(bool selected, {required ItalianTense tense}) onSelectedTense;
  final bool Function(ItalianTense) isSelected;

  @override
  Widget build(BuildContext context) {
    // SELECT -> Listen, Rebuild ...
    context.select<SettingsViewModel, List<ItalianTense>>((vm) => vm.tenseFilters);
    debugPrint("$_logTag | build()");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.maxFinite,
          child: Container(
            padding: EdgeInsets.all(AppValues.p12),
            color: context.colorScheme.surfaceContainerHigh,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: AppValues.fs18,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppValues.p12),
          child: Wrap(
            spacing: AppValues.s8,
            children: italianTenses.map((italianTense) => FilterChip(
                label: Text(italianTense.label),
                selected: isSelected(italianTense),
                onSelected: (selected) => onSelectedTense(selected, tense: italianTense),
            )).toList(),
          ),
        )
      ],
    );
  }
}

