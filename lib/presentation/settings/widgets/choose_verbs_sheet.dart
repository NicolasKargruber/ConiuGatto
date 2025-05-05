import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/verb.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../view_models/settings_view_model.dart';

final String _logTag = (ChooseVerbsSheet).toString();

class ChooseVerbsSheet extends StatelessWidget {
  const ChooseVerbsSheet({super.key});

  _onSelectVerb(BuildContext context, bool selected, {required Verb verb}) {
    /*if (selected) {
      context.read<SettingsViewModel>().addCustomVerb(verb);
    } else {
      context.read<SettingsViewModel>().removeCustomVerb(verb);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    List<Verb> verbs = context.read<SettingsViewModel>().verbs;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(12),
            child: Text("Choose from the Verbs below", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          ),

          _buildVerbSection(verbs),
        ],
      ),
    );
  }

  _buildVerbSection(List<Verb> verbs) {
    return Builder(
      builder: (context) {
        final viewModel = context.watch<SettingsViewModel>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Container(
                padding: EdgeInsets.all(AppValues.p12),
                color: context.colorScheme.surfaceContainerHigh,
                child: Text("Verbs", style: TextStyle(fontWeight: FontWeight.w500, fontSize: AppValues.fs18)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppValues.p12),
              child: Wrap(
                spacing: AppValues.s8,
                children: verbs.map((verb) => FilterChip(
                  label: Text(verb.italianInfinitive),
                  selected: true/*viewModel.isCustomVerbSelected(verb)*/,
                  onSelected: (selected) => _onSelectVerb(context, selected, verb: verb),
                )).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}