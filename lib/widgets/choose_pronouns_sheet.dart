import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/shared_preference_keys.dart';
import '../models/moods/conditional.dart';
import '../models/moods/imperative.dart';
import '../models/moods/indicative.dart';
import '../models/moods/subjunctive.dart';
import '../models/pronoun.dart';
import '../models/tenses/tense.dart';
import '../models/verb.dart';
import '../view_models/verb_view_model.dart';

class ChoosePronounsSheet extends StatefulWidget {
  const ChoosePronounsSheet({super.key});

  @override
  State<ChoosePronounsSheet> createState() => _ChoosePronounsSheetState();
}

class _ChoosePronounsSheetState extends State<ChoosePronounsSheet> {
  late String logTag = (widget).toString();
  
  // SharedPreferences
  late final SharedPreferences prefs;
  final key = SharedPreferenceKeys.quizzablePronouns;
  Set<String> _pronounPrefs = {};

  Future _loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _pronounPrefs = prefs.getStringList(key)?.toSet() ?? {};
    });
  }

  _onSelectPronoun(bool selected, {required String prefValue}) {
    setState(() {
      if(selected) {
        _pronounPrefs.add(prefValue);
        debugPrint("$logTag | Added $prefValue");
      }
      else {
        _pronounPrefs.remove(prefValue);
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
    prefs.setStringList(key, _pronounPrefs.toList());
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(12),
            child: Text(
              "Choose from the Pronouns below",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),

          _buildPronounSection(Pronoun.values)
        ],
      ),
    );
  }

  _buildPronounSection(List<Pronoun> pronouns) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.maxFinite,
          child: Container(
            padding: EdgeInsets.all(12),
            color: Colors.black12,
            child: Text(
              "Pronouns",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Wrap(
            spacing: 8,
            children: pronouns.map((pronoun) {
              return FilterChip(
                    label: Text(pronoun.italian),
                    selected: _pronounPrefs.contains(pronoun.prefKey),
                    onSelected: (selected) =>
                        _onSelectPronoun(selected, prefValue: pronoun.prefKey)
                );
            },
            ).toList(),
          ),
        )
      ],
    );
  }
}
