import 'package:flutter/material.dart';

import '../data/app_values.dart';
import '../main.dart';
import '../models/pronoun.dart';
import '../utilities/extensions/build_context_extensions.dart';

class ChoosePronounsSheet extends StatefulWidget {
  const ChoosePronounsSheet({super.key});

  @override
  State<ChoosePronounsSheet> createState() => _ChoosePronounsSheetState();
}

class _ChoosePronounsSheetState extends State<ChoosePronounsSheet> {
  late String logTag = (widget).toString();
  
  // SharedPreferences
  Set<String> _pronounPrefs = {};

  _loadPrefs() {
    setState(() {
      _pronounPrefs = preferenceManager.loadPronounPrefs();
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
    debugPrint("$logTag | dispose() ");
    preferenceManager.updatePronounPrefs(_pronounPrefs);
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
