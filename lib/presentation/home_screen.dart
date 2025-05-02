import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/service/verb_manager.dart';
import 'grammar/grammar_screen.dart';
import 'quiz/screens/quiz_screen.dart';
import 'quiz/view_models/quiz_view_model.dart';
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
    GrammarScreen(),
    // Quiz Screen
    ChangeNotifierProxyProvider<VerbManager, QuizViewModel>(
      create: (_) => QuizViewModel(),
      update: (_, verbManager, quizViewModel) => quizViewModel!..updateVerbs(verbManager.verbs),
      child: QuizScreen(),
    ),
    ChangeNotifierProxyProvider<VerbManager, SearchViewModel>(
      create: (_) => SearchViewModel(),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.badge_outlined),
            label: 'Grammar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark_rounded),
            label: 'Quiz',
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
