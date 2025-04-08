import 'package:coniugatto/view_models/verb_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'verb_detail_screen.dart';

class VerbScreen extends StatelessWidget {
  const VerbScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verbs 📚')),
      body: FutureBuilder(
        future: context.read<VerbViewModel>().initializationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (context.read<VerbViewModel>().verbs.isEmpty) {
            return Center(child: Text('No verbs available'));
          } else {
            final verbs = context.read<VerbViewModel>().verbs;
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