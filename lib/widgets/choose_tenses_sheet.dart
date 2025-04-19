import 'package:flutter/material.dart';

import '../data/shared_preference_keys.dart';
import '../main.dart';
import '../models/moods/conditional.dart';
import '../models/moods/imperative.dart';
import '../models/moods/indicative.dart';
import '../models/moods/subjunctive.dart';
import '../models/tenses/tense.dart';

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
      padding: const EdgeInsets.symmetric(vertical:4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(12),
            child: Text(
              "Choose from the Tenses below",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),

          _buildMoodSection(Indicative.name, Indicative.getLabeledTenses),
          _buildMoodSection(Conditional.name, Conditional.getLabeledTenses),
          _buildMoodSection(Subjunctive.name, Subjunctive.getLabeledTenses),
          _buildMoodSection(Imperative.name, Imperative.getLabeledTenses),
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
            padding: EdgeInsets.all(12),
            color: Colors.black12,
            child: Text(
              moodLabel,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Wrap(
            spacing: 8,
            children: labeledTenses.map((labeledTense) {
              final prefKey = (labeledTense.$1).toString();
              return FilterChip(
                    label: Text(labeledTense.label),
                    selected: _tensePrefs.contains(prefKey),
                    onSelected: (selected) =>
                        _onSelectTense(selected, prefValue: prefKey)
                );
            },
            ).toList(),
          ),
        )
      ],
    );
  }
}
