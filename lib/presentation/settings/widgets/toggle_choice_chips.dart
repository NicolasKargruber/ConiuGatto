import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';

class ToggleChoiceChips<Filter> extends StatelessWidget {
  const ToggleChoiceChips({super.key,
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
          padding: const EdgeInsets.symmetric(horizontal: AppValues.p36, vertical: AppValues.p12),
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