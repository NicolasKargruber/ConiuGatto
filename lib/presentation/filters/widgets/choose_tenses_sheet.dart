import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/enums/italian_tense.dart';
import '../../../domain/models/enums/language_level.dart';
import '../../../domain/models/enums/mood.dart';
import '../../../domain/utils/language_level_extensions.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import 'language_level_toggle_chips.dart';
import '../view_models/filters_view_model.dart';

class ChooseTensesSheet extends StatelessWidget {
  const ChooseTensesSheet({super.key});

  static final String _logTag = (ChooseTensesSheet).toString();

  @override
  Widget build(BuildContext context) {
    debugPrint("$_logTag | build()");
    final viewModel = context.watch<FiltersViewModel>();

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

          Container(
            padding: EdgeInsets.symmetric(horizontal: AppValues.p12),
            alignment: AlignmentDirectional.center,
            constraints: BoxConstraints(
              maxWidth: double.infinity,
              maxHeight: AppValues.s36,
            ),
            child: LanguageLevelChips(),
          ),

          SizedBox(height: AppValues.s16),

          MoodSection(
              label: Mood.indicative.label,
              italianTenses: ItalianTense.indicativeTenses,
              onSelectedTense: onSelectTense,
              onSelectedAll: () => viewModel.addTenseFilters(ItalianTense.indicativeTenses),
              isSelected: viewModel.isTenseSelected,
          ),

          MoodSection(
              label: Mood.conditional.label,
              italianTenses: ItalianTense.conditionalTenses,
            onSelectedAll: () => viewModel.addTenseFilters(ItalianTense.conditionalTenses),
            onSelectedTense: onSelectTense,
              isSelected: viewModel.isTenseSelected,
          ),

          MoodSection(
              label: Mood.subjunctive.label,
              italianTenses: ItalianTense.subjunctiveTenses,
            onSelectedAll: () => viewModel.addTenseFilters(ItalianTense.subjunctiveTenses),
            onSelectedTense: onSelectTense,
              isSelected: viewModel.isTenseSelected,
          ),

          MoodSection(
              label: Mood.imperative.label,
              italianTenses: ItalianTense.imperativeTenses,
            onSelectedAll: () => viewModel.addTenseFilters(ItalianTense.imperativeTenses),
            onSelectedTense: onSelectTense,
              isSelected: viewModel.isTenseSelected,
          ),

          SizedBox(height: AppValues.s24),
        ],
      ),
    );
  }
}

class MoodSection<M> extends StatelessWidget {
  static final String _logTag = (MoodSection).toString();

  const MoodSection({super.key,
    required this.label,
    required this.italianTenses,
    required this.onSelectedAll,
    required this.onSelectedTense,
    required this.isSelected,
  });

  final String label;
  final List<ItalianTense> italianTenses;
  final Function() onSelectedAll;
  final Function(bool selected, {required ItalianTense tense}) onSelectedTense;
  final bool Function(ItalianTense) isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: AppValues.p16, vertical: AppValues.p4),
          color: context.colorScheme.surfaceContainerHigh,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: AppValues.fs18),
              ),

              TextButton(
                onPressed: onSelectedAll,
                child: Text("Select All",
                  style: TextStyle(fontSize: AppValues.fs16),
                ),
              ),
            ],
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

