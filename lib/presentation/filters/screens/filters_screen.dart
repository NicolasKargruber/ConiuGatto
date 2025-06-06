import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../view_models/filters_view_model.dart';
import '../widgets/choose_pronouns_sheet.dart';
import '../widgets/choose_tenses_sheet.dart';
import '../widgets/choose_verb_filters_sheet.dart';

final _logTag = (FiltersScreen).toString();

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});
  _showChooseTensesSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (_) => ChangeNotifierProvider.value(
        value: context.read<FiltersViewModel>(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ChooseTensesSheet(),
        ),
      ),
    );
  }

  _showChooseVerbFiltersSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (_) => ChangeNotifierProvider.value(
          value: context.read<FiltersViewModel>(),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ChooseVerbFiltersSheet(),
          ),
        ),
    );
  }

  _showChoosePronounsSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (_) => ChangeNotifierProvider.value(
        value: context.read<FiltersViewModel>(),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ChoosePronounsSheet(),
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Filters 🕹️")),
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
                  onPressed: () => _showChooseVerbFiltersSheet(context),
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
