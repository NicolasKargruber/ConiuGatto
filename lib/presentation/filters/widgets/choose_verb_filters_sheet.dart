import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/enums/irregularity.dart';
import '../../../data/enums/regularity.dart';
import '../../../domain/models/enums/auxiliary_filter.dart';
import '../../../domain/models/enums/reflexive_verb.dart';
import '../../../domain/models/enums/verb_ending_filter.dart';
import '../../../domain/models/enums/verb_favourite_filter.dart';
import '../../../domain/models/enums/verb_irregularity_filter.dart';
import '../../../domain/models/verb.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../view_models/filters_view_model.dart';
import 'choose_verbs_sheet.dart';
import 'toggle_choice_chips.dart';

class ChooseVerbFiltersSheet extends StatelessWidget {
  const ChooseVerbFiltersSheet({super.key});

  static final _logTag = (ChooseVerbFiltersSheet).toString();

  // TODO Delete
  _showChooseVerbsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ChangeNotifierProvider.value(
        value: context.read<FiltersViewModel>(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ChooseVerbsSheet(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("$_logTag | build()");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppValues.p4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(AppValues.p12),
            child: Text(context.localization.verbsSheetSubtitle,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: AppValues.fs18),
            ),
          ),

          _VerbFavouriteChoiceChips(),

          SizedBox(height: AppValues.s4),

          _AuxiliaryChoiceChips(),

          SizedBox(height: AppValues.s4),

          _VerbEndingChoiceChips(),

          SizedBox(height: AppValues.s4),

          _VerbIrregularityChoiceChips(),

          SizedBox(height: AppValues.s24),
        ],
      ),
    );
  }
}

class _AuxiliaryChoiceChips extends StatelessWidget {
  const _AuxiliaryChoiceChips({super.key});

  static final _logTag = (_AuxiliaryChoiceChips).toString();

  @override
  Widget build(BuildContext context) {
    //debugPrint("$_logTag | build()");
    return ToggleChoiceChips<AuxiliaryFilter>(
      title: context.localization.auxiliaryLabel,
      labels: AuxiliaryFilter.values.map((e) => e.label).toList(),
      values: AuxiliaryFilter.values,
      selected: context.select<FiltersViewModel, AuxiliaryFilter?>((vm) => vm.auxiliaryFilter),
      onSelected: context.read<FiltersViewModel>().updateAuxiliaryFilter,
    );
  }
}

class _VerbEndingChoiceChips extends StatelessWidget {
  const _VerbEndingChoiceChips({super.key});

  static final _logTag = (_VerbEndingChoiceChips).toString();

  @override
  Widget build(BuildContext context) {
    //debugPrint("$_logTag | build()");
    return ToggleChoiceChips<VerbEndingFilter>(
      title: context.localization.endingLabel,
      labels: VerbEndingFilter.values.map((e) => e.label).toList(),
      values: VerbEndingFilter.values,
      selected: context.select<FiltersViewModel, VerbEndingFilter?>((vm) => vm.endingFilter),
      onSelected: context.read<FiltersViewModel>().updateEndingFilter,
    );
  }
}

class _VerbFavouriteChoiceChips extends StatelessWidget {
  const _VerbFavouriteChoiceChips({super.key});

  static final _logTag = (_VerbFavouriteChoiceChips).toString();

  @override
  Widget build(BuildContext context) {
    //debugPrint("$_logTag | build()");
    return ToggleChoiceChips<VerbFavouriteFilter>(
      title: context.localization.verbsLabel,
      labels: VerbFavouriteFilter.values.map((e) => e.label).toList(),
      values: VerbFavouriteFilter.values,
      selected: context.select<FiltersViewModel, VerbFavouriteFilter?>((vm) => vm.favouriteFilter),
      onSelected: context.read<FiltersViewModel>().updateFavouriteFilter,
    );
  }
}

class _VerbIrregularityChoiceChips extends StatelessWidget {
  const _VerbIrregularityChoiceChips({super.key});

  static final _logTag = (_VerbIrregularityChoiceChips).toString();

  @override
  Widget build(BuildContext context) {
    //debugPrint("$_logTag | build()");
    return ToggleChoiceChips<VerbIrregularityFilter>(
      title: context.localization.irregularityLabel,
      labels: VerbIrregularityFilter.values.map((e) => e.label).toList(),
      values: VerbIrregularityFilter.values,
      selected: context.select<FiltersViewModel, VerbIrregularityFilter?>((vm) => vm.irregularityFilter),
      onSelected: context.read<FiltersViewModel>().updateIrregularityFilter,
    );
  }
}

