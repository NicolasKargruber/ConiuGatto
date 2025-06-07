import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/enums/language_level.dart';
import '../../../domain/models/enums/mood.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../../about/screens/about_screen.dart';
import '../view_models/tenses_view_model.dart';
import '../widgets/language_level_toggle_chips.dart';
import '../widgets/language_level_section.dart';

class TensesScreen extends StatelessWidget {
  static final _logTag = (TensesScreen).toString();
  const TensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TensesViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Tenses 📊"),
        actions: [
          IconButton(onPressed: () => AboutScreen.show(context), icon: Icon(Icons.settings_rounded)),
        ],
      ),
      body: DefaultTabController(
        initialIndex: 0,
        length: Mood.values.length,
        child: Padding(
          padding: const EdgeInsets.all(AppValues.p4),
          child: ListView(
            children: [
              LanguageLevelSection(
                quizzedLevel: viewModel.quizzedLevelA1,
              ),

              LanguageLevelSection(
                quizzedLevel: viewModel.quizzedLevelA2,
              ),

              LanguageLevelSection(
                quizzedLevel: viewModel.quizzedLevelB1,
              ),

              LanguageLevelSection(
                quizzedLevel: viewModel.quizzedLevelB2,
              ),

              LanguageLevelSection(
                quizzedLevel: viewModel.quizzedLevelC1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

