import 'package:flutter/material.dart';

import '../models/verb.dart';
import 'verb_detail_screen.dart';

class VerbScreen extends StatefulWidget {
  const VerbScreen({super.key});

  @override
  State<VerbScreen> createState() => _VerbScreenState();
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ConiuGatto 🇮🇹')),
      body: FutureBuilder<List<Verb>>(
        future: futureVerbs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (verbs.isEmpty) {
            return Center(child: Text('No verbs available'));
          } else {
            return ListView.builder(
              itemCount: verbs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(verbs[index].infinitive),
                  subtitle: Text(verbs[index].translation),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerbDetailScreen(verb: verbs[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}