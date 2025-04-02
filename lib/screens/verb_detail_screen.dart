import 'package:coniugatto/screens/conjugation_table.dart';
import 'package:flutter/material.dart';

import '../models/auxiliary.dart';
import '../models/verb.dart';

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
              child: FilledButton(onPressed: (){}, child: Text(widget.verb.regularity.name)),
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
              title: Text('Indicativo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConjugationTable(conjugatedTenses: [
                    (label: 'Presente', conjugations: widget.verb.indicative.present),
                    (label: 'Presente Progressivo', conjugations: widget.verb.indicative.presentContinuous),
                    (label: 'Imperfetto', conjugations: widget.verb.indicative.imperfect),
                    (label: 'Passato Prossimo', conjugations: widget.verb.indicative.presentPerfect(selectedAuxiliary)),
                    (label: 'Trapassato Prossimo', conjugations: widget.verb.indicative.pastPerfect(selectedAuxiliary)),
                    (label: 'Passato Remoto', conjugations: widget.verb.indicative.historicalPresentPerfect),
                    (label: 'Trapassato Remoto', conjugations: widget.verb.indicative.historicalPastPerfect(selectedAuxiliary)),
                    (label: 'Futuro', conjugations: widget.verb.indicative.future),
                    (label: 'Futuro Anteriore', conjugations: widget.verb.indicative.futurePerfect(selectedAuxiliary)),
                  ]),
                )
              ],
            ),

            // CONGIUNTIVO
            ExpansionTile(
              title: Text('Congiuntivo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConjugationTable(conjugatedTenses: [
                    (label: 'Presente', conjugations: widget.verb.subjunctive.present),
                    (label: 'Imperfetto', conjugations: widget.verb.subjunctive.imperfect),
                    (label: 'Passato', conjugations: widget.verb.subjunctive.presentPerfectSubjunctive(selectedAuxiliary)),
                    (label: 'Trapassato', conjugations: widget.verb.subjunctive.pastPerfectSubjunctive(selectedAuxiliary)),
                  ]),
                ),
              ],
            ),

            // CONDIZIONALE
            ExpansionTile(
              title: Text('Condizionale', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConjugationTable(conjugatedTenses: [
                    (label: 'Presente', conjugations: widget.verb.conditional.present),
                    (label: 'Passato', conjugations: widget.verb.conditional.presentPerfectConditional(selectedAuxiliary)),
                  ]),
                ),
              ],
            ),

            // IMPERATIVO
            ExpansionTile(
              title: Text('Imperativo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConjugationTable(conjugatedTenses: [
                    (label: 'Positivo', conjugations: widget.verb.imperative.positive),
                    (label: 'Negative', conjugations: widget.verb.imperative.negative),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
