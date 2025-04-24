import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

import '../data/app_values.dart';
import '../models/auxiliary.dart';
import '../models/moods/conditional.dart';
import '../models/moods/imperative.dart';
import '../models/moods/indicative.dart';
import '../models/moods/subjunctive.dart';
import '../models/verb.dart';
import '../widgets/conjugation_table.dart';

class VerbDetailScreen extends StatefulWidget {
  final Verb verb;

  const VerbDetailScreen({super.key, required this.verb});

  @override
  State<VerbDetailScreen> createState() => _VerbDetailScreenState();
}

class _VerbDetailScreenState extends State<VerbDetailScreen> {
  final _logTag = (VerbDetailScreen).toString();

  late Auxiliary selectedAuxiliary;
  List<bool> selectedAuxiliaries = [true, false];

  @override
  void initState() {
    selectedAuxiliary = widget.verb.auxiliaries.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              child: widget.verb.isRegular ?
              FilledButton(onPressed: (){}, child: Text(widget.verb.regularity.name)) :
              FilledButton.tonal(onPressed: (){}, child: Text(widget.verb.regularity.name)),
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

            Divider(color: context.colors.scheme.surfaceBright),

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
                        Text(Indicative.name, style: TextStyle(fontSize: AppValues.fs18, fontWeight: FontWeight.bold)),
                        ConjugationTable(tenses: [
                          widget.verb.indicative.present,
                          widget.verb.indicative.presentContinuous,
                          widget.verb.indicative.imperfect,
                          widget.verb.indicative.presentPerfect(selectedAuxiliary),
                          widget.verb.indicative.pastPerfect(selectedAuxiliary),
                          widget.verb.indicative.historicalPresentPerfect,
                          widget.verb.indicative.historicalPastPerfect(selectedAuxiliary),
                          widget.verb.indicative.future,
                          widget.verb.indicative.futurePerfect(selectedAuxiliary),
                        ])
                      ],
                    ),
                  ),

                  Divider(height: AppValues.s36, color: context.colors.scheme.surfaceBright),

                  // CONGIUNTIVO
                  Padding(
                    padding: const EdgeInsets.all(AppValues.p4),
                    child: Column(
                      spacing: AppValues.s16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Subjunctive.name, style: TextStyle(fontSize: AppValues.fs18, fontWeight: FontWeight.bold)),
                        ConjugationTable(tenses: [
                          widget.verb.subjunctive.present,
                          widget.verb.subjunctive.imperfect,
                          widget.verb.subjunctive.presentPerfectSubjunctive(selectedAuxiliary),
                         widget.verb.subjunctive.pastPerfectSubjunctive(selectedAuxiliary),
                        ]),
                      ],
                    ),
                  ),

                  Divider(height: AppValues.s36, color: context.colors.scheme.surfaceBright),

                  // CONDIZIONALE
                  Padding(
                    padding: const EdgeInsets.all(AppValues.p4),
                    child: Column(
                      spacing: AppValues.s16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Conditional.name, style: TextStyle(fontSize: AppValues.fs18, fontWeight: FontWeight.bold)),
                        ConjugationTable(tenses: [
                          widget.verb.conditional.present,
                          widget.verb.conditional.presentPerfectConditional(selectedAuxiliary),
                        ]),
                      ],
                    ),
                  ),

                  Divider(height: AppValues.s36, color: context.colors.scheme.surfaceBright),

                  // IMPERATIVO
                  Padding(
                    padding: const EdgeInsets.all(AppValues.p4),
                    child: Column(
                      spacing: AppValues.s16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Imperative.name, style: TextStyle(fontSize: AppValues.fs18, fontWeight: FontWeight.bold)),
                        ConjugationTable(
                            tenses: [
                              widget.verb.imperative.positive,
                              widget.verb.imperative.negative,
                        ], showEnglishPronouns: false),
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
