import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/enums/mood.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../view_models/history_view_model.dart';
import '../widgets/language_level_toggle_chips.dart';
import '../widgets/tense_history_list_view.dart';

class HistoryScreen extends StatelessWidget {
  static final _logTag = (HistoryScreen).toString();
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HistoryViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text("Tenses 📊")),
      body: DefaultTabController(
        initialIndex: 0,
        length: Mood.values.length,
        child: Padding(
          padding: const EdgeInsets.all(AppValues.p4),
          child: ListView(
            children: [
              TenseHistoryListView(
                quizzedTenses: viewModel.a1Tenses,
              ),

              Padding(
                padding: const EdgeInsets.all(AppValues.p8),
                child: Divider(),
              ),

              TenseHistoryListView(
                quizzedTenses: viewModel.a2Tenses,
              ),

              Padding(
                padding: const EdgeInsets.all(AppValues.p8),
                child: Divider(),
              ),

              TenseHistoryListView(
                quizzedTenses: viewModel.b1Tenses,
              ),

              Padding(
                padding: const EdgeInsets.all(AppValues.p8),
                child: Divider(),
              ),

              TenseHistoryListView(
                quizzedTenses: viewModel.b2Tenses,
              ),

              Padding(
                padding: const EdgeInsets.all(AppValues.p8),
                child: Divider(),
              ),

              TenseHistoryListView(
                quizzedTenses: viewModel.c1Tenses,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

