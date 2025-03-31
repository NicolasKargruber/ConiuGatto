import 'package:coniugatto/models/moods/indicative.dart';
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
            Text(widget.verb.regularity.name),

            if(widget.verb.auxiliaries.length > 1)
            ToggleButtons(isSelected: [true, false], children: [Text(widget.verb.auxiliaries.first.name), Text(widget.verb.auxiliaries.last.name)]),

            // INDICATIVO
            ExpansionTile(
              title: Text('Indicativo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                _buildTenseTile('Presente', widget.verb.moods.indicative.present),
                _buildTenseTile('Imperfetto', widget.verb.moods.indicative.imperfect),
                _buildTenseTile('Passato Prossimo', widget.verb.moods.indicative.presentPerfect(selectedAuxiliary, widget.verb.pastParticiple)),
                _buildTenseTile('Passato Remoto', widget.verb.moods.indicative.historicalPresentPerfect),
                _buildTenseTile('Futuro Semplice', widget.verb.moods.indicative.simpleFuture),
              ],
            ),

            // CONGIUNTIVO
            ExpansionTile(
              title: Text('Congiuntivo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                _buildTenseTile('Presente', widget.verb.moods.subjunctive.present),
                _buildTenseTile('Imperfetto', widget.verb.moods.subjunctive.imperfect),
              ],
            ),

            // CONDIZIONALE
            ExpansionTile(
              title: Text('Condizionale', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                _buildTenseTile('Presente', widget.verb.moods.conditional.present),
              ],
            ),

            // IMPERATIVO
            ExpansionTile(
              title: Text('Imperativo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                _buildTenseTile('Positivo Afirmativo', widget.verb.moods.imperative.positive),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTenseTile(String tenseName, Conjugations conjugations) {
    return ExpansionTile(
      title: Text(tenseName),
      children: [ConjugationTable(conjugations: conjugations)],
    );
  }
}
