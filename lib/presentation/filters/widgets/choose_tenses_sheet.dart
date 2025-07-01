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
import 'mood_section.dart';

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

    onSelectLanguageLevel(bool selected, {required LanguageLevel level}) {
      if(selected) { viewModel.addTenseFilters(level.coveredTenses); }
      else { viewModel.removeTenseFilters(level.coveredTenses); }
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
              context.localization.tensesSheetSubtitle,
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
            child: LanguageLevelChips(
              isSelected: viewModel.coversLanguageLevel,
              onSelected: onSelectLanguageLevel,
            ),
          ),

          SizedBox(height: AppValues.s16),

          MoodSection(
            label: Mood.indicative.label,
            italianTenses: ItalianTense.indicativeTenses,
            onSelectedTense: onSelectTense,
            onSelectedAll: () => viewModel.addTenseFilters(ItalianTense.indicativeTenses),
            onUnselectedAll: () => viewModel.removeTenseFilters(ItalianTense.indicativeTenses),
            areAllSelected: viewModel.coversMood(Mood.indicative),
            isSelected: viewModel.isTenseSelected,
          ),

          MoodSection(
            label: Mood.conditional.label,
            italianTenses: ItalianTense.conditionalTenses,
            onSelectedAll: () => viewModel.addTenseFilters(ItalianTense.conditionalTenses),
            onUnselectedAll: () => viewModel.removeTenseFilters(ItalianTense.conditionalTenses),
            onSelectedTense: onSelectTense,
            areAllSelected: viewModel.coversMood(Mood.conditional),
            isSelected: viewModel.isTenseSelected,
          ),

          MoodSection(
            label: Mood.subjunctive.label,
            italianTenses: ItalianTense.subjunctiveTenses,
            onSelectedAll: () => viewModel.addTenseFilters(ItalianTense.subjunctiveTenses),
            onUnselectedAll: () => viewModel.removeTenseFilters(ItalianTense.subjunctiveTenses),
            onSelectedTense: onSelectTense,
            areAllSelected: viewModel.coversMood(Mood.subjunctive),
            isSelected: viewModel.isTenseSelected,
          ),

          MoodSection(
            label: Mood.imperative.label,
            italianTenses: ItalianTense.imperativeTenses,
            onSelectedAll: () => viewModel.addTenseFilters(ItalianTense.imperativeTenses),
            onUnselectedAll: () => viewModel.removeTenseFilters(ItalianTense.imperativeTenses),
            onSelectedTense: onSelectTense,
            areAllSelected: viewModel.coversMood(Mood.imperative),
            isSelected: viewModel.isTenseSelected,
          ),

          SizedBox(height: AppValues.s24),
        ],
      ),
    );
  }
}

