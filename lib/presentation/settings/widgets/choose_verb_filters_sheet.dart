import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../data/enums/irregularity.dart';
import '../../../data/enums/regularity.dart';
import '../../../domain/models/enums/reflexive_verb.dart';
import '../../../domain/models/enums/verb_ending_filter.dart';
import '../../../domain/models/enums/verb_favourite_filter.dart';
import '../../../domain/models/enums/verb_irregularity_filter.dart';
import '../../../domain/models/verb.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../view_models/settings_view_model.dart';
import 'choose_verbs_sheet.dart';

final String _logTag = (ChooseVerbFiltersSheet).toString();

class ChooseVerbFiltersSheet extends StatelessWidget {
  const ChooseVerbFiltersSheet({super.key});

  _onSelectedFavouriteFilter(BuildContext context, {required VerbFavouriteFilter favourite}) {
      context.read<SettingsViewModel>().updateVerbFavouriteFilter(favourite);
  }

  _onSelectedVerbEndingFilter(BuildContext context, {required VerbEndingFilter ending}) {
      context.read<SettingsViewModel>().updateEndingFilter(ending);
  }

  // TODO in CON-12
  /*_onSelectedReflexiveFilter(BuildContext context, {required ReflexiveVerb reflexive}) {
    context.read<SettingsViewModel>().updateReflexiveFilter(reflexive);
  }*/

  _onSelectedIrregularityFilter(BuildContext context, {required VerbIrregularityFilter irregularity}) {
      context.read<SettingsViewModel>().updateIrregularityFilter(irregularity);
  }

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

          ToggleSection<VerbFavouriteFilter>(
            title: "Verbs",
            labels: VerbFavouriteFilter.values.map((e) => e.label).toList(),
            values: VerbFavouriteFilter.values,
            selected: context.watch<SettingsViewModel>().verbFavouriteFilter,
            //onUnselectedAll: () {},
            onSelected: (favourite) => _onSelectedFavouriteFilter(context, favourite: favourite),
          ),

          ToggleSection<VerbEndingFilter>(
            title: "Endings",
            labels: VerbEndingFilter.values.map((e) => e.label).toList(),
            values: VerbEndingFilter.values,
            selected: context.watch<SettingsViewModel>().endingFilter,
            //onUnselectedAll: () {},
            onSelected: (ending) => _onSelectedVerbEndingFilter(context, ending: ending),
          ),

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

          ToggleSection<VerbIrregularityFilter>(
            title: "Irregularity",
            labels: VerbIrregularityFilter.values.map((e) => e.label).toList(),
            values: VerbIrregularityFilter.values,
            selected: context.watch<SettingsViewModel>().irregularityFilter,
            //onUnselectedAll: () {},
            onSelected: (irregularity) => _onSelectedIrregularityFilter(context, irregularity: irregularity),
          ),

          SizedBox(height: AppValues.s24),
        ],
      ),
    );
  }
}

class ToggleSection<Filter> extends StatelessWidget {
  const ToggleSection({super.key,
    required this.title,
    required this.values,
    required this.labels,
    required this.selected,
    //required this.onUnselectedAll,
    required this.onSelected,
  });

  final String title;
  final List<String> labels;
  final List<Filter> values;
  final Filter selected;
  //final Function() onUnselectedAll;
  final Function(Filter) onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(AppValues.p12),
          color: context.colorScheme.surfaceContainerHigh,
          child: Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: AppValues.fs18)),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.p36, vertical: AppValues.p8),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: AppValues.s8,
            children: [
              //FilterChip(label: Text("All"), onSelected: (_) => onUnselectedAll(),),
              ...values.mapIndexed((index, filter) => ChoiceChip(
                label: Text(labels[index]),
                selected: filter == selected,
                onSelected: (_) => onSelected(filter),
              )),
              /*ActionChip(label: Text(VerbFavourites.custom.label),
                  onPressed: () =>_showChooseVerbsSheet(context),
                ),*/
            ],
          ),
        ),
      ],
    );
  }
}

