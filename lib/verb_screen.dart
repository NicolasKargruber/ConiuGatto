import 'dart:math';
import 'package:flutter/material.dart';

import 'verb.dart';

class VerbScreen extends StatefulWidget {
  @override
  _VerbScreenState createState() => _VerbScreenState();
}

class _VerbScreenState extends State<VerbScreen> {
  late Future<List<Verb>> futureVerbs;
  Verb? currentVerb;
  List<Verb> verbs = [];

  @override
  void initState() {
    super.initState();
    futureVerbs = loadVerbs();
    futureVerbs.then((loadedVerbs) {
      setState(() {
        verbs = loadedVerbs;
        _pickRandomVerb();
      });
    });
  }

  void _pickRandomVerb() {
    if (verbs.isNotEmpty) {
      setState(() {
        currentVerb = verbs[Random().nextInt(verbs.length)];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Random Verb')),
      body: FutureBuilder<List<Verb>>(
        future: futureVerbs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (currentVerb == null) {
            return Center(child: Text('No verbs available'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${currentVerb!.infinitive} (${currentVerb!.translation})',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: currentVerb!.conjugations.entries.map((entry) {
                        final tense = entry.key;
                        final forms = entry.value as Map<String, dynamic>;
                        return ExpansionTile(
                          title: Text(
                            tense[0].toUpperCase() + tense.substring(1),
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          children: forms.entries.map((form) {
                            return ListTile(
                              title: Text('${form.key}: ${form.value}'),
                            );
                          }).toList(),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: _pickRandomVerb,
                      child: Text('Show Another Verb'),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}