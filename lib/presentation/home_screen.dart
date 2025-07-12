import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';

import '../domain/service/history_service.dart';
import '../domain/service/in_app_review_service.dart';
import '../domain/service/package_info_service.dart';
import '../domain/service/shared_preference_service.dart';
import '../domain/service/verb_service.dart';
import '../l10n/app_localizations.dart';
import '../utilities/extensions/build_context_extensions.dart';
import 'about/screens/about_screen.dart';
import 'review/screens/review_screen.dart';
import 'review/view_models/review_view_model.dart';
import 'tenses/screens/tenses_screen.dart';
import 'tenses/view_models/tenses_view_model.dart';
import 'verbs/screens/verbs_screen.dart';
import 'verbs/view_models/search_view_model.dart';

final _logTag = (HomeScreen).toString();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final InAppReviewService _inAppReviewService;

  int _currentIndex = 1;
  final List<Widget> _screens = [
    // Grammar
    //GrammarScreen(),
    // History
    ChangeNotifierProxyProvider<HistoryService, TensesViewModel>(
      create: (context) => TensesViewModel(
          context.read<SharedPreferenceService>(),
          context.read<HistoryService>(),
          context,
      ),
      update: (_, historyService, historyViewModel) => historyViewModel!..updateHistory(historyService.quizzedQuestions),
      child: TensesScreen(),
    ),
    // Quiz
    ChangeNotifierProxyProvider<VerbService, ReviewViewModel>(
      create: (context) => ReviewViewModel(
          context.read<SharedPreferenceService>(),
          context.read<HistoryService>(),
      ),
      update: (_, verbManager, reviewViewModel) => reviewViewModel!..updateVerbs(verbManager.verbs),
      child: ReviewScreen(),
    ),
    // Verbs
    ChangeNotifierProxyProvider<VerbService, SearchViewModel>(
      create: (context) => SearchViewModel(context.read<SharedPreferenceService>(), context),
      update: (_, verbManager, searchViewModel) => searchViewModel!..updateVerbs(verbManager.verbs),
      child: VerbsScreen(),
    ),
  ];

  @override
  void initState() {
    if(context.mounted) {
      _inAppReviewService = context.read<InAppReviewService>();
      _inAppReviewService.initializationFuture.then((_) => _inAppReviewService.maybeRequestReview());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          /*BottomNavigationBarItem(
            icon: Icon(Icons.badge_outlined),
            label: 'Grammar',
          ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            label: context.localization.tensesLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark_rounded),
            label: context.localization.reviewLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories_rounded),
            label: context.localization.verbsLabel,
          ),
        ],
      ),
    );
  }
}
