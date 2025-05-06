import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/enums/pronoun.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../view_models/settings_view_model.dart';


class ChoosePronounsSheet extends StatelessWidget {
  const ChoosePronounsSheet({super.key});

  static final String _logTag = (ChoosePronounsSheet).toString();
  
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

          _PronounFilterChips(),

          SizedBox(height: AppValues.s24),
        ],
      ),
    );
  }
}

class _PronounFilterChips extends StatelessWidget {
  const _PronounFilterChips({super.key});

  static final _logTag = (_PronounFilterChips).toString();

  @override
  Widget build(BuildContext context) {
    debugPrint("$_logTag | build()");
    // SELECT -> Listen, Rebuild ...
    context.select<SettingsViewModel, List<Pronoun>>((vm) => vm.pronounFilters);
    final viewModel = context.read<SettingsViewModel>();
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
            children: Pronoun.values.map((pronoun) => FilterChip(
                label: Text(pronoun.italian),
                selected: viewModel.isPronounSelected(pronoun),
                onSelected: (selected) {
                  if(selected) { viewModel.addPronounFilter(pronoun); }
                  else { viewModel.removePronounFilter(pronoun); }
                },
            )).toList(),
          ),
        )
      ],
    );
  }
}

