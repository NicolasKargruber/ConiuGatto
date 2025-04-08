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
      appBar: AppBar(title: Text(widget.verb.infinitive)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.verb.regularity.isRegular ?
              FilledButton.tonal(onPressed: (){}, child: Text(widget.verb.regularity.name)) :
              FilledButton(onPressed: (){}, child: Text(widget.verb.regularity.name)),
            ),

            if(widget.verb.auxiliaries.length > 1)
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: ToggleButtons(
                  isSelected: selectedAuxiliaries,
                  onPressed: (index){
                    setState(() {
                      selectedAuxiliary = widget.verb.auxiliaries[index];
                      selectedAuxiliaries = [false, false];
                      selectedAuxiliaries[index] = true;
                    });
                  },
                  children: [
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.verb.auxiliaries.first.name.toUpperCase()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.verb.auxiliaries.last.name.toUpperCase()),
                )
              ]),
            ),

            // INDICATIVO
            ExpansionTile(
              initiallyExpanded: true,
              title: Text(Indicative.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConjugationTable(tenses: [
                    widget.verb.indicative.present,
                    widget.verb.indicative.presentContinuous,
                    widget.verb.indicative.imperfect,
                    widget.verb.indicative.presentPerfect(selectedAuxiliary),
                    widget.verb.indicative.pastPerfect(selectedAuxiliary),
                    widget.verb.indicative.historicalPresentPerfect,
                    widget.verb.indicative.historicalPastPerfect(selectedAuxiliary),
                    widget.verb.indicative.future,
                    widget.verb.indicative.futurePerfect(selectedAuxiliary),
                  ]),
                )
              ],
            ),

            // CONGIUNTIVO
            ExpansionTile(
              title: Text(Subjunctive.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConjugationTable(tenses: [
                    widget.verb.subjunctive.present,
                    widget.verb.subjunctive.imperfect,
                    widget.verb.subjunctive.presentPerfectSubjunctive(selectedAuxiliary),
                   widget.verb.subjunctive.pastPerfectSubjunctive(selectedAuxiliary),
                  ]),
                ),
              ],
            ),

            // CONDIZIONALE
            ExpansionTile(
              title: Text(Conditional.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConjugationTable(tenses: [
                    widget.verb.conditional.present,
                    widget.verb.conditional.presentPerfectConditional(selectedAuxiliary),
                  ]),
                ),
              ],
            ),

            // IMPERATIVO
            ExpansionTile(
              title: Text(Imperative.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConjugationTable(
                      tenses: [
                        widget.verb.imperative.positive,
                        widget.verb.imperative.negative,
                  ], showEnglishPronouns: false),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
