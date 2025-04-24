import '../data/app_values.dart';
import '../view_models/search_view_model.dart';
import '../view_models/verb_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'verb_detail_screen.dart';

class VerbScreen extends StatelessWidget {
  VerbScreen({super.key});

  final _logTag = (VerbScreen).toString();

  final _searchTextController = TextEditingController();

  clearSearch(BuildContext context) {
    context.read<SearchViewModel>().filterVerbs('');
    _searchTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("$_logTag | build()");
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
            final verbs = context.watch<SearchViewModel>().filteredVerbs;
            debugPrint("$_logTag | verbs: ${verbs.map((e) => e.italianInfinitive).toList()}");
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppValues.p16),
                  child: SearchBar(
                    controller: _searchTextController,
                    leading: Padding(
                      padding: const EdgeInsets.all(AppValues.p8),
                      child: Icon(Icons.search, color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                    trailing: [
                      Padding(
                        padding: const EdgeInsets.all(AppValues.p8),
                        child: ClipOval(
                          child: SizedBox(
                            width: AppValues.s24,
                            height: AppValues.s24,
                            child: IconButton.filled(
                              padding: EdgeInsets.all(AppValues.p0),
                              onPressed: () => clearSearch(context),
                              icon: Icon(Icons.clear, size: AppValues.s12, color: Theme.of(context).colorScheme.onPrimary),
                            ),
                          ),
                        ),
                      ),
                    ],
                    hintText: 'Search verbs...',
                    onChanged: context.read<SearchViewModel>().filterVerbs,
                    elevation: WidgetStateProperty.all(0.0),
                  ),
                ),
                Expanded(
                  child: Scrollbar(
                    interactive: true,
                    thumbVisibility: true,
                    child: ListView.builder(
                      itemCount: verbs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(verbs[index].italianInfinitive),
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
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}