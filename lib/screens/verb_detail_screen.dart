import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:  8.0),
              child: Text(widget.verb.italianInfinitive, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:  8.0),
              child: Text(widget.verb.translation, style: TextStyle(fontSize: 16,)),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: widget.verb.isRegular ?
              FilledButton.tonal(onPressed: (){}, child: Text(widget.verb.regularity.name)) :
              FilledButton(onPressed: (){}, child: Text(widget.verb.regularity.name)),
            ),

            // TODO Move to separate widget
            if(widget.verb.isDoubleAuxiliary)
              Container(
                alignment: Alignment.center,
                child: ToggleButtons(
                    borderRadius: BorderRadius.circular(24.0),
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
                        padding: const EdgeInsets.all(12.0),
                        child: Text(widget.verb.auxiliaries.first.name.toUpperCase()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(widget.verb.auxiliaries.last.name.toUpperCase()),
                      )
                    ]),
              ),

            SizedBox(height: 8),

            Divider(),

            Expanded(
              child: ListView(
                children: [
                  // INDICATIVO
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      spacing: 16.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Indicative.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

                  Divider(height: 36.0),

                  // CONGIUNTIVO
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      spacing: 16.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Subjunctive.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ConjugationTable(tenses: [
                          widget.verb.subjunctive.present,
                          widget.verb.subjunctive.imperfect,
                          widget.verb.subjunctive.presentPerfectSubjunctive(selectedAuxiliary),
                         widget.verb.subjunctive.pastPerfectSubjunctive(selectedAuxiliary),
                        ]),
                      ],
                    ),
                  ),

                  Divider(height: 36.0),

                  // CONDIZIONALE
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      spacing: 16.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Conditional.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ConjugationTable(tenses: [
                          widget.verb.conditional.present,
                          widget.verb.conditional.presentPerfectConditional(selectedAuxiliary),
                        ]),
                      ],
                    ),
                  ),

                  Divider(height: 36.0),

                  // IMPERATIVO
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      spacing: 16.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Imperative.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
