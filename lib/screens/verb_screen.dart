import 'package:coniugatto/view_models/verb_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/verb.dart';
import 'verb_detail_screen.dart';

// TODO Make stateless
class VerbScreen extends StatefulWidget {
  const VerbScreen({super.key});

  @override
  State<VerbScreen> createState() => _VerbScreenState();
}

class _VerbScreenState extends State<VerbScreen> {
  late Future _loadingVerbs;
  Verb? currentVerb;
  List<Verb> get verbs => context.read<VerbViewModel>().verbs;

  @override
  void initState() {
    super.initState();
    _loadingVerbs = context.read<VerbViewModel>().loadVerbs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verbs 📚')),
      body: FutureBuilder(
        future: _loadingVerbs,
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