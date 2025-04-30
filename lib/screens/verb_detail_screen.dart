import 'package:flutter/material.dart';

import '../data/app_values.dart';
import '../models/auxiliary.dart';
import '../models/moods/mood.dart';
import '../models/verb.dart';
import '../utilities/extensions/build_context_extensions.dart';
import '../utilities/extensions/verb_extensions.dart';
import '../widgets/conjugation_table.dart';

class VerbDetailScreen extends StatefulWidget {
  final Verb verb;

  const VerbDetailScreen({super.key, required this.verb});

  @override
  State<VerbDetailScreen> createState() => _VerbDetailScreenState();
}

class _VerbDetailScreenState extends State<VerbDetailScreen> {
  final _logTag = (VerbDetailScreen).toString();
  get verb => widget.verb;

  // TODO factory
  // Colors
  Color dividerColor(BuildContext context) {
    return context.isLightMode ?
    context.colorScheme.surfaceDim :
    context.colorScheme.surfaceBright;
  }

  // Optional auxiliaries
  late Auxiliary selectedAuxiliary;
  List<bool> selectedAuxiliaries = [true, false];

  @override
  void initState() {
    selectedAuxiliary = widget.verb.auxiliaries.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("$_logTag | build()");
    debugPrint("$_logTag | Irregularities: ${widget.verb.irregularities}");
    
    return Scaffold(
      appBar: AppBar(title: Text(widget.verb.italianInfinitive)),
      body: Padding(
        padding: const EdgeInsets.all(AppValues.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppValues.p8),
              child: Text(widget.verb.italianInfinitive, style: TextStyle(fontSize: AppValues.fs24, fontWeight: FontWeight.bold )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppValues.p8),
              child: Text(widget.verb.translation, style: TextStyle(fontSize: AppValues.fs16,)),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppValues.p8),
              // TODO factory
              child: widget.verb.isRegular ?
              FilledButton(onPressed: (){}, child: Text("Regular")) :
              FilledButton.tonal(onPressed: (){}, child: Text("Irregular")),
            ),

            // TODO Move to separate widget
            if(widget.verb.isDoubleAuxiliary)
              Container(
                alignment: Alignment.center,
                child: ToggleButtons(
                    borderRadius: BorderRadius.circular(AppValues.r24),
                    isSelected: selectedAuxiliaries,
                    onPressed: (index) {
                      setState(() {
                        selectedAuxiliary = widget.verb.auxiliaries.elementAt(index);
                        selectedAuxiliaries = [false, false];
                        selectedAuxiliaries[index] = true;
                      });
                    },
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppValues.p12),
                        child: Text(widget.verb.auxiliaries.first.name.toUpperCase()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppValues.p12),
                        child: Text(widget.verb.auxiliaries.last.name.toUpperCase()),
                      )
                    ]),
              ),

            SizedBox(height: AppValues.s8),

            Divider(color: dividerColor(context)),

            Expanded(
              child: ListView(
                children: [
                  // INDICATIVO
                  Padding(
                    padding: const EdgeInsets.all(AppValues.p4),
                    child: Column(
                      spacing: AppValues.s16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Mood.indicative.label, style: TextStyle(fontSize: AppValues.fs18, fontWeight: FontWeight.bold)),
                        ConjugationTable(
                          tenses: widget.verb.getIndicativeTenses(selectedAuxiliary, includeGenerated: true),
                        )
                      ],
                    ),
                  ),

                  Divider(height: AppValues.s36, color: dividerColor(context)),

                  // CONGIUNTIVO
                  Padding(
                    padding: const EdgeInsets.all(AppValues.p4),
                    child: Column(
                      spacing: AppValues.s16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Mood.subjunctive.label, style: TextStyle(fontSize: AppValues.fs18, fontWeight: FontWeight.bold)),
                        ConjugationTable(
                          tenses: widget.verb.getSubjunctiveTenses(selectedAuxiliary, includeGenerated: true),
                        ),
                      ],
                    ),
                  ),

                  Divider(height: AppValues.s36, color: dividerColor(context)),

                  // CONDIZIONALE
                  Padding(
                    padding: const EdgeInsets.all(AppValues.p4),
                    child: Column(
                      spacing: AppValues.s16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Mood.conditional.label, style: TextStyle(fontSize: AppValues.fs18, fontWeight: FontWeight.bold)),
                        ConjugationTable(
                          tenses: widget.verb.getConditionalTenses(selectedAuxiliary, includeGenerated: true),
                        ),
                      ],
                    ),
                  ),

                  Divider(height: AppValues.s36, color: dividerColor(context)),

                  // IMPERATIVO
                  Padding(
                    padding: const EdgeInsets.all(AppValues.p4),
                    child: Column(
                      spacing: AppValues.s16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Mood.imperative.label, style: TextStyle(fontSize: AppValues.fs18, fontWeight: FontWeight.bold)),
                        ConjugationTable(
                            tenses: widget.verb.getImperativeTenses(includeGenerated: true),
                            showEnglishPronouns: false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
