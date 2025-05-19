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
import '../view_models/settings_view_model.dart';
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
        value: context.read<SettingsViewModel>(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ChooseVerbsSheet(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppValues.p4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(AppValues.p12),
            child: Text("Choose from the Filters below",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: AppValues.fs18),
            ),
          ),

          _VerbFavouriteChoiceChips(),

          SizedBox(height: AppValues.s4),

          _AuxiliaryChoiceChips(),

          SizedBox(height: AppValues.s4),

          _VerbEndingChoiceChips(),

          // TODO in CON-12
          /*Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p12, vertical: AppValues.p16),
            child: ToggleSwitch(
              labels: ReflexiveVerb.values.map((e) => e.label).toList(),
              dividerColor:  context.colorScheme.onSurface,
              inactiveBgColor: context.colorScheme.surfaceContainerLowest,
              activeBgColor: [context.colorScheme.primary],
              onToggle: (index) => _onSelectedReflexiveFilter(context, reflexive: ReflexiveVerb.values[index!]),
            ),
          ),*/

          /*ToggleSection<VerbIrregularityFilter>(
            title: "Irregularity",
            labels: VerbIrregularityFilter.values.map((e) => e.label).toList(),
            values: VerbIrregularityFilter.values,
            selected: context.watch<SettingsViewModel>().irregularityFilter,
            //onUnselectedAll: () {},
            onSelected: (irregularity) => _onSelectedIrregularityFilter(context, irregularity: irregularity),
          ),*/

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
    debugPrint("$_logTag | build()");
    return ToggleChoiceChips<AuxiliaryFilter>(
      title: "Auxiliary",
      labels: AuxiliaryFilter.values.map((e) => e.label).toList(),
      values: AuxiliaryFilter.values,
      selected: context.select<SettingsViewModel, AuxiliaryFilter>((vm) => vm.auxiliaryFilter),
      onSelected: context.read<SettingsViewModel>().updateAuxiliaryFilter,
    );
  }
}

class _VerbEndingChoiceChips extends StatelessWidget {
  const _VerbEndingChoiceChips({super.key});

  static final _logTag = (_VerbEndingChoiceChips).toString();

  @override
  Widget build(BuildContext context) {
    debugPrint("$_logTag | build()");
    return ToggleChoiceChips<VerbEndingFilter>(
      title: "Endings",
      labels: VerbEndingFilter.values.map((e) => e.label).toList(),
      values: VerbEndingFilter.values,
      selected: context.select<SettingsViewModel, VerbEndingFilter>((vm) => vm.endingFilter),
      onSelected: context.read<SettingsViewModel>().updateEndingFilter,
    );
  }
}

class _VerbFavouriteChoiceChips extends StatelessWidget {
  const _VerbFavouriteChoiceChips({super.key});

  static final _logTag = (_VerbFavouriteChoiceChips).toString();

  @override
  Widget build(BuildContext context) {
    debugPrint("$_logTag | build()");
    return ToggleChoiceChips<VerbFavouriteFilter>(
      title: "Verbs",
      labels: VerbFavouriteFilter.values.map((e) => e.label).toList(),
      values: VerbFavouriteFilter.values,
      selected: context.select<SettingsViewModel, VerbFavouriteFilter>((vm) => vm.favouriteFilter),
      onSelected: context.read<SettingsViewModel>().updateFavouriteFilter,
    );
  }
}

