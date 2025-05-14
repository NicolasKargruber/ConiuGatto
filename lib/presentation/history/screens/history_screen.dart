import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/enums/mood.dart';
import '../../../utilities/app_values.dart';
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
      appBar: AppBar(title: Text("History ⏳")),
      body: DefaultTabController(
        initialIndex: 0,
        length: Mood.values.length,
        child: Padding(
          padding: const EdgeInsets.all(AppValues.p4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: double.infinity,
                  maxHeight: AppValues.s36,
                ),
                child: LanguageLevelChoiceChips(
                  value: viewModel.selectedLanguageLevel,
                  onSelected: viewModel.selectLanguageLevel,
                ),
              ),

              SizedBox(height: AppValues.s12),

              TabBar(
                tabs: Mood.values.map((mood) => Tab(text: mood.label)).toList(),
              ),

              Flexible(
                flex: 10,
                fit: FlexFit.loose,
                child: TabBarView(
                  children: <Widget>[
                    // Indicative
                    TenseHistoryListView(
                      quizzedTenses: viewModel.indicativeTenses,
                    ),
                    // Subjunctive
                    TenseHistoryListView(
                      quizzedTenses: viewModel.subjunctiveTenses,
                    ),
                    // Conditional
                    TenseHistoryListView(
                      quizzedTenses: viewModel.conditionalTenses,
                    ),
                    // Imperative
                    TenseHistoryListView(
                      quizzedTenses: viewModel.imperativeTenses,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

