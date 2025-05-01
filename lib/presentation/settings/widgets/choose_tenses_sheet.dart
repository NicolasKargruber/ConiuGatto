import 'package:flutter/material.dart';

import '../../../utilities/app_values.dart';
import '../../../utilities/shared_preference_keys.dart';
import '../../../main.dart';
import '../../../data/enums/mood.dart';
import '../../../data/enums/italian_tense.dart';
import '../../../utilities/extensions/build_context_extensions.dart';

class ChooseTensesSheet extends StatefulWidget {
  const ChooseTensesSheet({super.key});

  @override
  State<ChooseTensesSheet> createState() => _ChooseTensesSheetState();
}

class _ChooseTensesSheetState extends State<ChooseTensesSheet> {
  late String logTag = (widget).toString();
  
  // SharedPreferences
  final key = SharedPreferenceKeys.quizzableTenses;
  Set<String> _tensePrefs = {};

   _loadPrefs() {
    setState(() {
      _tensePrefs = preferenceManager.loadTensePrefs();
    });
  }

  _onSelectTense(bool selected, {required String prefValue}) {
    setState(() {
      if(selected) {
        _tensePrefs.add(prefValue);
        debugPrint("$logTag | Added $prefValue");
      }
      else {
        _tensePrefs.remove(prefValue);
        debugPrint("$logTag | Removed $prefValue");
      }
    });
  }

  @override
  void initState() {
    debugPrint("$logTag | initState() ");
    _loadPrefs();
    super.initState();
  }

  @override
  void dispose() {
    debugPrint("$logTag | dispose() ");
    preferenceManager.updateTensePrefs(_tensePrefs);
    super.dispose();
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
              "Choose from the Tenses below",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: AppValues.fs18,
              ),
            ),
          ),

          _buildMoodSection(Mood.indicative.label, ItalianTense.indicativeLabeledPrefs),
          _buildMoodSection(Mood.conditional.label, ItalianTense.conditionalLabeledPrefs),
          _buildMoodSection(Mood.subjunctive.label, ItalianTense.subjunctiveLabeledPrefs),
          _buildMoodSection(Mood.imperative.label, ItalianTense.imperativeLabeledPrefs),
        ],
      ),
    );
  }

  _buildMoodSection(String moodLabel, List<LabeledPrefs> labeledPrefs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.maxFinite,
          child: Container(
            padding: EdgeInsets.all(AppValues.p12),
            color: context.colorScheme.surfaceContainerHigh,
            child: Text(
              moodLabel,
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
            children: labeledPrefs.map((labeledTense) {
              return FilterChip(
                    label: Text(labeledTense.label),
                    selected: _tensePrefs.contains(labeledTense.prefKey),
                    onSelected: (selected) => _onSelectTense(selected, prefValue: labeledTense.prefKey)
                );
            },
            ).toList(),
          ),
        )
      ],
    );
  }
}
