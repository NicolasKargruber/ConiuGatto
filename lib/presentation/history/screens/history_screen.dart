import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/enums/language_levels.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../../../utilities/widget_factory.dart';
import '../view_models/history_view_model.dart';

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
        length: 4,
        child: Padding(
          padding: const EdgeInsets.all(AppValues.p16),
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: ListView.separated(
                  itemCount: LanguageLevel.values.length,
                  separatorBuilder: (context, index) => SizedBox(width: AppValues.s12),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final level = LanguageLevel.values[index];
                    return CustomChip(
                    label: level.label,
                    onSelected: (selected) {
                      if(selected) viewModel.selectLanguageLevel(level);
                    },
                    selected: level == viewModel.selectedLanguageLevel,
                  );
                  },
                ),
              ),

              SizedBox(height: AppValues.s8),

              const TabBar(
                tabs: <Widget>[
                  Tab(text: 'Indicative',),
                  Tab(text: 'Subjunctive',),
                  Tab(text: 'Conditional',),
                  Tab(text: 'Imperative',),
                ],
              ),

              Flexible(
                flex: 10,
                fit: FlexFit.loose,
                child: TabBarView(
                  children: <Widget>[
                    ListView(
                      children: [
                        SizedBox(height: AppValues.s16),

                        ItalianTenseProgress.createCard(
                            title: "Presente",
                            subtitle: "Last quizzed: 10 days ago",
                            progress: 0.8,
                        ),

                        SizedBox(height: AppValues.s8),

                        ItalianTenseProgress.createCard(
                          title: "Presente Progressivo",
                          subtitle: "Last quizzed: Never",
                          progress: 0.5,
                        ),

                        SizedBox(height: AppValues.s8),

                        ItalianTenseProgress.createCard(
                          title: "Imperfetto",
                          subtitle: "Last quizzed: Never",
                          progress: 0.5,
                        ),

                        SizedBox(height: AppValues.s8),

                        ItalianTenseProgress.createCard(
                          title: "Passato Prossimo",
                          subtitle: "Last quizzed: Never",
                          progress: 0.5,
                        ),

                        SizedBox(height: AppValues.s8),

                        ItalianTenseProgress.createCard(
                          title: "Trapassato Prossimo",
                          subtitle: "Last quizzed: Never",
                          progress: 0.5,
                        ),

                        SizedBox(height: AppValues.s8),

                        ItalianTenseProgress.createCard(
                          title: "Passato Remoto",
                          subtitle: "Last quizzed: Never",
                          progress: 0.5,
                        ),

                        SizedBox(height: AppValues.s8),

                        ItalianTenseProgress.createCard(
                          title: "Trapassato Remoto",
                          subtitle: "Last quizzed: Never",
                          progress: 0.5,
                        ),

                        SizedBox(height: AppValues.s8),

                        ItalianTenseProgress.createCard(
                          title: "Futuro",
                          subtitle: "Last quizzed: Never",
                          progress: 0.5,
                        ),

                        SizedBox(height: AppValues.s8),

                        ItalianTenseProgress.createCard(
                          title: "Futuro Anteriore",
                          subtitle: "Last quizzed: Never",
                          progress: 0.5,
                        ),

                        SizedBox(height: AppValues.s16),
                      ],
                    ),
                    ListView(
                      children: [
                        SizedBox(height: AppValues.s16),

                        ItalianTenseProgress.createCard(
                          title: "Presente",
                          subtitle: "Last quizzed: 10 days ago",
                          progress: 0.8,
                        ),

                        SizedBox(height: AppValues.s8),

                        ItalianTenseProgress.createCard(
                          title: "Imperfetto",
                          subtitle: "Last quizzed: 2 days ago",
                          progress: 0.6,
                        ),

                        SizedBox(height: AppValues.s8),

                        ItalianTenseProgress.createCard(
                          title: "Passato",
                          subtitle: "Last quizzed: Yesterday",
                          progress: 0.4,
                        ),

                        SizedBox(height: AppValues.s8),

                        ItalianTenseProgress.createCard(
                          title: "Trapassato",
                          subtitle: "Last quizzed: Yesterday",
                          progress: 0.4,
                        ),

                        SizedBox(height: AppValues.s16),
                      ],
                    ),
                    ListView(
                      children: [
                        SizedBox(height: AppValues.s16),

                        ItalianTenseProgress.createCard(
                          title: "Presente",
                          subtitle: "Last quizzed: Never",
                          progress: 0.5,
                        ),

                        SizedBox(height: AppValues.s8),

                        ItalianTenseProgress.createCard(
                          title: "Passato",
                          subtitle: "Last quizzed: Never",
                          progress: 0.5,
                        ),

                        SizedBox(height: AppValues.s16),
                      ],
                    ),
                    ListView(
                      children: [
                        SizedBox(height: AppValues.s16),

                        ItalianTenseProgress.createCard(
                          title: "Presente",
                          subtitle: "Last quizzed: Today",
                          progress: 1.0,
                        ),

                        SizedBox(height: AppValues.s8),

                        ItalianTenseProgress.createCard(
                          title: "Negativo",
                          subtitle: "Last quizzed: Today",
                          progress: 0.95,
                        ),

                        SizedBox(height: AppValues.s16),
                      ],
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

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.selected,
    required this.label,
    required this.onSelected,
  });

  final bool selected;
  final String label;
  final Function(bool) onSelected;

  @override
  Widget build(BuildContext context) {
    return RawChip(
      selected: selected,
      onSelected: onSelected,
      label: Text(label,
        style: TextStyle(color: context.colorScheme.onPrimaryContainer),
      ),
      side: BorderSide(color: context.colorScheme.surfaceContainerHigh),
      backgroundColor: context.colorScheme.surfaceContainerHigh,
      selectedColor: context.colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(AppValues.r24))),
      showCheckmark: false,
    );
  }
}
