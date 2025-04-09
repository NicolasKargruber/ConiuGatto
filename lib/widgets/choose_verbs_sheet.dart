import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/shared_preference_keys.dart';
import '../models/moods/conditional.dart';
import '../models/moods/imperative.dart';
import '../models/moods/indicative.dart';
import '../models/moods/subjunctive.dart';
import '../models/tenses/tense.dart';
import '../models/verb.dart';
import '../view_models/verb_view_model.dart';

class ChooseVerbsSheet extends StatefulWidget {
  const ChooseVerbsSheet({super.key});

  @override
  State<ChooseVerbsSheet> createState() => _ChooseVerbsSheetState();
}

class _ChooseVerbsSheetState extends State<ChooseVerbsSheet> {
  late String logTag = (widget).toString();
  
  // SharedPreferences
  late final SharedPreferences prefs;
  final key = SharedPreferenceKeys.quizzableVerbs;
  Set<String> _verbLabels = {};

  Future _loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _verbLabels = prefs.getStringList(key)?.toSet() ?? {};
    });
  }

  // Choosing from
  late final List<Verb> _verbs = context.read<VerbViewModel>().verbs;

  _onSelectVerb(bool selected, {required String prefValue}) {
    setState(() {
      if(selected) {
        _verbLabels.add(prefValue);
        debugPrint("$logTag | Added $prefValue");
      }
      else {
        _verbLabels.remove(prefValue);
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
    debugPrint("$logTag | Dispose() ");
    prefs.setStringList(key, _verbLabels.toList());
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
            "Choose from the Verbs below",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),

        _buildVerbSection(_verbs)
      ],
    );
  }

  _buildVerbSection(List<Verb> verbs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.maxFinite,
          child: Container(
            padding: EdgeInsets.all(12),
            color: Colors.black12,
            child: Text(
              "Verbs",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Wrap(
            spacing: 8,
            children: verbs.map((verb) {
              return FilterChip(
                    label: Text(verb.infinitive),
                    selected: _verbLabels.contains(verb.prefKey),
                    onSelected: (selected) =>
                        _onSelectVerb(selected, prefValue: verb.prefKey)
                );
            },
            ).toList(),
          ),
        )
      ],
    );
  }
}
