import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/verb_view_model.dart';
import '../widgets/choose_tenses_sheet.dart';
import '../widgets/choose_verbs_sheet.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  _showSelectTensesSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ChooseTensesSheet(),
      ),
    );
  }

  _showSelectVerbsSheet(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings ⚙️")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.black12,
              child: Text(
                "Tenses",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 8),
          ListTile(
            title: Text("The following tenses will be included in your Quiz."),
          ),
          ListTile(
            title: Center(
              child: FilledButton.tonal(
                onPressed: () => _showSelectTensesSheet(context),
                child: Text("Update tenses"),
              ),
            ),
          ),

          SizedBox(height: 8),

          SizedBox(
            width: double.maxFinite,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.black12,
              child: Text(
                "Verbs",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 8),
          ListTile(
            title: Text(
              "The following verbs will be included up in your Quiz.",
            ),
          ),
          ListTile(
            title: Center(
              child: FilledButton.tonal(
                onPressed: () => _showSelectVerbsSheet(context),
                child: Text("Update verbs"),
              ),
            ),
          ),

          SizedBox(height: 8),

          SizedBox(
            width: double.maxFinite,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.black12,
              child: Text(
                "Pronouns",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 8),
          ListTile(
            title: Text(
              "The following pronouns will be included up in your Quiz.",
            ),
          ),
          ListTile(
            title: Center(
              child: FilledButton.tonal(
                onPressed: null,
                child: Text("Update pronouns"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
