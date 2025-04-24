import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

import '../data/app_values.dart';
import '../models/auxiliary.dart';
import '../models/moods/conditional.dart';
import '../models/moods/imperative.dart';
import '../models/moods/indicative.dart';
import '../models/moods/subjunctive.dart';
import '../models/verb.dart';
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

  // Colors
  Color dividerColor(BuildContext context) {
    return context.isLightMode ?
    context.colors.scheme.surfaceDim : 
    context.colors.scheme.surfaceBright;
  }

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
                        Text(Indicative.name, style: TextStyle(fontSize: AppValues.fs18, fontWeight: FontWeight.bold)),
                        ConjugationTable(
                            tenses: [
                          widget.verb.indicative.present..generatedConjugations = widget.verb.generatedPresentIndicative,
                          widget.verb.indicative.presentContinuous..generatedConjugations = widget.verb.generatedPresentContinuousIndicative,
                          widget.verb.indicative.imperfect..generatedConjugations = widget.verb.generatedImperfectIndicative,
                          widget.verb.indicative.presentPerfect(selectedAuxiliary)..generatedConjugations = widget.verb.generatedPresentPerfectIndicative(selectedAuxiliary),
                          widget.verb.indicative.pastPerfect(selectedAuxiliary)..generatedConjugations = widget.verb.generatedPastPerfectIndicative(selectedAuxiliary),
                          widget.verb.indicative.historicalPresentPerfect..generatedConjugations = widget.verb.generatedHistoricalPresentPerfectIndicative,
                          widget.verb.indicative.historicalPastPerfect(selectedAuxiliary)..generatedConjugations = widget.verb.generatedHistoricalPastPerfectIndicative(selectedAuxiliary),
                          widget.verb.indicative.future..generatedConjugations = widget.verb.generatedFutureIndicative,
                          widget.verb.indicative.futurePerfect(selectedAuxiliary)..generatedConjugations = widget.verb.generatedFuturePerfectIndicative(selectedAuxiliary),
                        ], stem: widget.verb.stem,
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
                        Text(Subjunctive.name, style: TextStyle(fontSize: AppValues.fs18, fontWeight: FontWeight.bold)),
                        ConjugationTable(tenses: [
                          widget.verb.subjunctive.present..generatedConjugations = widget.verb.generatedPresentSubjunctive,
                          widget.verb.subjunctive.imperfect..generatedConjugations = widget.verb.generatedImperfectSubjunctive,
                          widget.verb.subjunctive.presentPerfectSubjunctive(selectedAuxiliary)..generatedConjugations = widget.verb.generatedPresentPerfectSubjunctive(selectedAuxiliary),
                          widget.verb.subjunctive.pastPerfectSubjunctive(selectedAuxiliary)..generatedConjugations = widget.verb.generatedPastPerfectSubjunctive(selectedAuxiliary),
                        ]),
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
                        Text(Conditional.name, style: TextStyle(fontSize: AppValues.fs18, fontWeight: FontWeight.bold)),
                        ConjugationTable(tenses: [
                          widget.verb.conditional.present..generatedConjugations = widget.verb.generatedPresentConditional,
                          widget.verb.conditional.presentPerfectConditional(selectedAuxiliary)..generatedConjugations = widget.verb.generatedPresentPerfectConditional(selectedAuxiliary),
                        ]),
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
                        Text(Imperative.name, style: TextStyle(fontSize: AppValues.fs18, fontWeight: FontWeight.bold)),
                        ConjugationTable(
                            tenses: [
                              widget.verb.imperative.positive..generatedConjugations = widget.verb.generatedPositiveImperative,
                              widget.verb.imperative.negative..generatedConjugations = widget.verb.generatedNegativeImperative,
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
