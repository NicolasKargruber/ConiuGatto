import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/service/verb_service.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../../about/screens/about_screen.dart';
import 'verbs_content.dart';

final _logTag = (VerbsScreen).toString();

class VerbsScreen extends StatelessWidget {
  VerbsScreen({super.key});

  final _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    debugPrint("$_logTag | build()");
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localization.verbsAppTitle),
        actions: [
          IconButton(onPressed: () => AboutScreen.show(context), icon: Icon(Icons.settings_rounded)),
        ],
      ),
      body: FutureBuilder(
        future: context.read<VerbService>().initializationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (context.read<VerbService>().verbs.isEmpty) {
            return Center(child: Text(context.localization.noVerbsAvailable));
          } else {
            return VerbsContent(
              searchTextController: _searchTextController,
            );
          }
        },
      ),
    );
  }
}