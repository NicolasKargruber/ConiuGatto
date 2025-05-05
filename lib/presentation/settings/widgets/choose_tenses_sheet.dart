import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/enums/italian_tense.dart';
import '../../../domain/models/enums/mood.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../view_models/settings_view_model.dart';

final String _logTag = (ChooseTensesSheet).toString();

class ChooseTensesSheet extends StatelessWidget {
  const ChooseTensesSheet({super.key});

  _onSelectTense(BuildContext context, bool selected, {required ItalianTense tense}) {
    if(selected) {
      context.read<SettingsViewModel>().addTenseFilter(tense);
    }
    else {
      context.read<SettingsViewModel>().removeTenseFilter(tense);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingsViewModel>();
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
              onSelectedTense: _onSelectTense,
              isSelected: viewModel.isTenseSelected,
          ),
          MoodSection(
              label: Mood.conditional.label,
              italianTenses: ItalianTense.conditionalTenses,
              onSelectedTense: _onSelectTense,
              isSelected: viewModel.isTenseSelected,
          ),
          MoodSection(
              label: Mood.subjunctive.label,
              italianTenses: ItalianTense.subjunctiveTenses,
              onSelectedTense: _onSelectTense,
              isSelected: viewModel.isTenseSelected,
          ),
          MoodSection(
              label: Mood.imperative.label,
              italianTenses: ItalianTense.imperativeTenses,
              onSelectedTense: _onSelectTense,
              isSelected: viewModel.isTenseSelected,
          ),
        ],
      ),
    );
  }
}

class MoodSection extends StatelessWidget {
  const MoodSection({super.key, required this.label, required this.italianTenses, required this.onSelectedTense, required this.isSelected});

  final String label;
  final List<ItalianTense> italianTenses;
  final Function(BuildContext, bool, {required ItalianTense tense}) onSelectedTense;
  final bool Function(ItalianTense) isSelected;

  @override
  Widget build(BuildContext context) {
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
                onSelected: (selected) => onSelectedTense(context, selected, tense: italianTense)
            )).toList(),
          ),
        )
      ],
    );
  }
}

