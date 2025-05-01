import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../view_models/search_view_model.dart';
import '../view_models/verb_detail_view_model.dart';
import 'verb_detail_screen.dart';

final _logTag = (VerbsContent).toString();

class VerbsContent extends StatelessWidget {
  const VerbsContent({super.key, required this.searchTextController});

  final TextEditingController searchTextController;

  clearSearch(BuildContext context) {
    context.read<SearchViewModel>().filterVerbs('');
    searchTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final verbs = context.watch<SearchViewModel>().filteredVerbs;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppValues.p16),
          child: _buildSearchBar(context),
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
                    Navigator.push(context,
                    MaterialPageRoute(
                          builder: (context) {
                            return ChangeNotifierProvider(
                              create: (_) => VerbDetailViewModel(verbs[index]),
                              child: VerbDetailScreen(),
                            );
                          },
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

  _buildSearchBar(BuildContext context){
    final viewModel = context.watch<SearchViewModel>();
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
      hintText: 'Search verbs...',
      onChanged: viewModel.filterVerbs,
      elevation: WidgetStateProperty.all(0.0),
    );
  }
}
