import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/service/history_service.dart';
import '../domain/service/shared_preference_service.dart';
import '../domain/service/verb_service.dart';
import 'history/screens/history_screen.dart';
import 'history/view_models/history_view_model.dart';
import 'review/screens/review_screen.dart';
import 'review/view_models/review_view_model.dart';
import 'verbs/screens/verbs_screen.dart';
import 'verbs/view_models/search_view_model.dart';

final _logTag = (HomeScreen).toString();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 1;
  final List<Widget> _screens = [
    // Grammar
    //GrammarScreen(),
    // History
    ChangeNotifierProxyProvider<HistoryService, HistoryViewModel>(
      create: (context) => HistoryViewModel(
          context.read<SharedPreferenceService>(),
          context.read<HistoryService>(),
      ),
      update: (_, historyService, historyViewModel) => historyViewModel!..updateHistory(historyService.quizzedQuestions),
      child: HistoryScreen(),
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
      create: (context) => SearchViewModel(context.read<SharedPreferenceService>()),
      update: (_, verbManager, searchViewModel) => searchViewModel!..updateVerbs(verbManager.verbs),
      child: VerbsScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
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
            label: 'Tenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark_rounded),
            label: 'Review',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories_rounded),
            label: 'Verbs',
          ),
        ],
      ),
    );
  }
}
