import 'package:flutter/material.dart';

import '../data/app_values.dart';
import '../data/shared_preference_keys.dart';
import '../main.dart';
import '../models/moods/conditional.dart';
import '../models/moods/imperative.dart';
import '../models/moods/indicative.dart';
import '../models/moods/subjunctive.dart';
import '../utilities/extensions/build_context_extensions.dart';

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

          _buildMoodSection(Indicative.name, IndicativeTense.valuesLabeled),
          _buildMoodSection(Conditional.name, ConditionalTense.valuesLabeled),
          _buildMoodSection(Subjunctive.name, SubjunctiveTense.valuesLabeled),
          _buildMoodSection(Imperative.name, ImperativeTense.valuesLabeled),
        ],
      ),
    );
  }

  _buildMoodSection(String moodLabel, List<LabeledTense> labeledTenses) {
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
            children: labeledTenses.map((labeledTense) {
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
