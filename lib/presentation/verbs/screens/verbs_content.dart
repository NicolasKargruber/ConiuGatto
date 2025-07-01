import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/service/shared_preference_service.dart';
import '../../../domain/utils/url_helper.dart';
import '../../../domain/utils/verb_extensions.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../../../utilities/widget_factory.dart';
import '../view_models/search_view_model.dart';
import '../view_models/verb_detail_view_model.dart';
import 'verb_detail_screen.dart';

class VerbsContent extends StatelessWidget {
  static final _logTag = (VerbsContent).toString();
  const VerbsContent({super.key, required this.searchTextController});

  final TextEditingController searchTextController;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchViewModel>();
    final verbs = viewModel.filteredVerbs;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppValues.p16),
          child: _SearchBar(searchTextController: searchTextController),
        ),
        Expanded(
          child: verbs.isEmpty ? Center(child: _RequestVerb()) : Scrollbar(
            interactive: true,
            thumbVisibility: true,
            child: ListView.builder(
              itemCount: verbs.length,
              itemBuilder: (context, index) {
                final verb = verbs[index];
                final isStarred = viewModel.isStarredVerb(verb);
                 return StarWidgetFactory.createDismissable(
                    key: ValueKey<String>(verb.italianInfinitive),
                    isStarred: isStarred,
                    onDismissed: () => viewModel.toggleStarredVerb(verb),
                    child: ListTile(
                      title: Text(verb.italianInfinitive),
                      subtitle: Text(verb.getTranslation(context)),
                      trailing: isStarred ? StarWidgetFactory.createIcon() : null,
                      onTap: () async {
                        await Navigator.push(context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider(
                              create: (_) => VerbDetailViewModel(verb, context.read<SharedPreferenceService>()),
                              child: VerbDetailScreen(),
                            ),
                          ),
                        );
                        viewModel.updateStarredVerbs();
                      },
                    ),
                 );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({super.key, required this.searchTextController});

  final TextEditingController searchTextController;

  clearSearch(BuildContext context) {
    searchTextController.clear();
    context.read<SearchViewModel>().filterVerbs(searchTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SearchViewModel>();
    searchTextController.text = viewModel.searchString;
    return SearchBar(
      controller: searchTextController,
      leading: Padding(
        padding: const EdgeInsets.all(AppValues.p8),
        child: Icon(Icons.search, color: context.colorScheme.onSurfaceVariant),
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
                icon: Icon(Icons.clear, size: AppValues.s12, color: context.colorScheme.onPrimary),
              ),
            ),
          ),
        ),
      ],
      hintText: context.localization.verbSearchbarHint,
      onChanged: viewModel.filterVerbs,
      elevation: WidgetStateProperty.all(0.0),
    );
  }
}

class _RequestVerb extends StatelessWidget {
  const _RequestVerb({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppValues.s12,
      children: [
        Text(context.localization.noVerbFound,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs16)
        ),
      FilledButton(
        onPressed: () {
          UrlHelper.sendMailToRequestVerb(context.read<SearchViewModel>().searchString.toUpperCase());
        },
        child: Text(context.localization.requestVerb),
      ),
      ],
    );
  }
}

