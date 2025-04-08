import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late final SharedPreferences prefs;
  Set<String> _tenseLabels = {};

  Future _loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _tenseLabels = prefs.getStringList('tenseLabels')?.toSet() ?? {};
    });
  }

  _onSelectTense(bool selected, {required String prefValue}) {
    setState(() {
      if(selected) { _tenseLabels.add(prefValue); }
      else { _tenseLabels.remove(prefValue); }
    });
  }

  @override
  void initState() {
    debugPrint("ChooseTensesSheet | initState() ");
    _loadPrefs();
    super.initState();
  }

  @override
  void dispose() {
    debugPrint("ChooseTensesSheet | Dispose() ");
    prefs.setStringList('tenseLabels', _tenseLabels.toList());
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
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
              final prefValue = "$moodLabel-${labeledTense.label}";
              return FilterChip(
                    label: Text(labeledTense.label),
                    selected: _tenseLabels.contains(prefValue),
                    onSelected: (selected) =>
                        _onSelectTense(selected, prefValue: prefValue)
                );
            },
            ).toList(),
          ),
        )
      ],
    );
  }
}
