import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/app_values.dart';
import '../utilities/extensions/build_context_extensions.dart';
import '../view_models/verb_view_model.dart';
import '../widgets/choose_pronouns_sheet.dart';
import '../widgets/choose_tenses_sheet.dart';
import '../widgets/choose_verbs_sheet.dart';

final _logTag = (SettingsScreen).toString();

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  _showChooseTensesSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ChooseTensesSheet(),
      ),
    );
  }

  _showChooseVerbsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        final verbViewModel = context.read<VerbViewModel>();
        return ChangeNotifierProvider.value(
          value: verbViewModel,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ChooseVerbsSheet(),
          ),
        );
      },
    );
  }

  _showChoosePronounsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        final verbViewModel = context.read<VerbViewModel>();
        return ChangeNotifierProvider.value(
          value: verbViewModel,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ChoosePronounsSheet(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings ⚙️")),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppValues.p16, vertical: AppValues.p12),
                color: context.colorScheme.surfaceContainer,
                child: Text(
                  "Tenses",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: AppValues.fs18),
                ),
              ),
            ),

            SizedBox(height: AppValues.s8),

            ListTile(
              title: Text("The following tenses will be included in your Quiz."),
            ),

            ListTile(
              title: Center(
                child: FilledButton.tonal(
                  onPressed: () => _showChooseTensesSheet(context),
                  child: Text("Update tenses"),
                ),
              ),
            ),
        
            SizedBox(height: AppValues.s8),
        
            SizedBox(
              width: double.maxFinite,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppValues.p16, vertical: AppValues.p12),
                color: context.colorScheme.surfaceContainer,
                child: Text(
                  "Verbs",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: AppValues.fs18),
                ),
              ),
            ),

            SizedBox(height: AppValues.s8),

            ListTile(
              title: Text(
                "The following verbs will be included up in your Quiz.",
              ),
            ),

            ListTile(
              title: Center(
                child: FilledButton.tonal(
                  onPressed: () => _showChooseVerbsSheet(context),
                  child: Text("Update verbs"),
                ),
              ),
            ),
        
            SizedBox(height: AppValues.s8),
        
            SizedBox(
              width: double.maxFinite,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppValues.p16, vertical: AppValues.p12),
                color: context.colorScheme.surfaceContainer,
                child: Text(
                  "Pronouns",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: AppValues.fs18),
                ),
              ),
            ),

            SizedBox(height: AppValues.s8),

            ListTile(
              title: Text(
                "The following pronouns will be included up in your Quiz.",
              ),
            ),

            ListTile(
              title: Center(
                child: FilledButton.tonal(
                  onPressed: ()=> _showChoosePronounsSheet(context),
                  child: Text("Update pronouns"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
