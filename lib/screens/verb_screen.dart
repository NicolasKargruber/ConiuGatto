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
                  padding: const EdgeInsets.all(16.0),
                  child: SearchBar(
                    controller: _searchTextController,
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.search),
                    ),
                    trailing: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipOval(
                          child: Container(
                            width: 24,
                            height: 24,
                            color: Colors.black12,
                            child: IconButton(
                              padding: EdgeInsets.all(0.0),
                              onPressed: () => clearSearch(context),
                              icon: Icon(Icons.clear, size: 12),
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