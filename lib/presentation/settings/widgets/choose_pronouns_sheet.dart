import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/enums/pronoun.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../view_models/settings_view_model.dart';

final String _logTag = (ChoosePronounsSheet).toString();

class ChoosePronounsSheet extends StatelessWidget {
  const ChoosePronounsSheet({super.key});

  _onSelectPronoun(BuildContext context, bool selected, {required Pronoun pronoun}) {
      if(selected) {
        context.read<SettingsViewModel>().addPronoun(pronoun);
      }
      else {
        context.read<SettingsViewModel>().removePronoun(pronoun);
      }
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppValues.p4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(AppValues.p12),
            child: Text(
              "Choose from the Pronouns below",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: AppValues.fs18,
              ),
            ),
          ),

          _buildPronounSection(Pronoun.values)
        ],
      ),
    );
  }

  _buildPronounSection(List<Pronoun> pronouns) {
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
                child: Text(
                  "Pronouns",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: AppValues.fs18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppValues.p12),
              child: Wrap(
                spacing: AppValues.s8,
                children: pronouns.map((pronoun) => FilterChip(
                    label: Text(pronoun.italian),
                    selected: viewModel.isPronounSelected(pronoun),
                    onSelected: (selected) => _onSelectPronoun(context, selected, pronoun: pronoun)
                )).toList(),
              ),
            )
          ],
        );
      }
    );
  }
}
