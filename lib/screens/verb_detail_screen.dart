import 'package:coniugatto/models/moods/indicative.dart';
import 'package:coniugatto/screens/conjugation_table.dart';
import 'package:flutter/material.dart';

import '../models/verb.dart';

class VerbDetailScreen extends StatelessWidget {
  final Verb verb;

  const VerbDetailScreen({super.key, required this.verb});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(verb.infinitive)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(verb.regularity.name),

            if(verb.auxiliaries.length > 1)
            ToggleButtons(isSelected: [true, false], children: [Text(verb.auxiliaries.first.name), Text(verb.auxiliaries.last.name)]),

            // INDICATIVO
            ExpansionTile(
              title: Text('Indicativo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                _buildTenseTile('Presente', verb.moods.indicative.present),
                _buildTenseTile('Imperfetto', verb.moods.indicative.imperfect),
                _buildTenseTile('Passato Remoto', verb.moods.indicative.historicalPresentPerfect),
                _buildTenseTile('Futuro Semplice', verb.moods.indicative.simpleFuture),
              ],
            ),

            // CONGIUNTIVO
            ExpansionTile(
              title: Text('Congiuntivo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                _buildTenseTile('Presente', verb.moods.subjunctive.present),
                _buildTenseTile('Imperfetto', verb.moods.subjunctive.imperfect),
              ],
            ),

            // CONDIZIONALE
            ExpansionTile(
              title: Text('Condizionale', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                _buildTenseTile('Presente', verb.moods.conditional.present),
              ],
            ),

            // IMPERATIVO
            ExpansionTile(
              title: Text('Imperativo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                _buildTenseTile('Positivo Afirmativo', verb.moods.imperative.positive),
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
