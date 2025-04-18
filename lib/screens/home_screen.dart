import '../view_models/search_view_model.dart';
import 'grammar_screen.dart';
import 'quiz_screen.dart';
import 'verb_screen.dart';
import '../view_models/quiz_view_model.dart';
import '../view_models/verb_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


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
    ChangeNotifierProxyProvider<VerbViewModel, QuizViewModel>(
      create: (_) => QuizViewModel(),
      update: (_, verbViewModel, quizViewModel) => quizViewModel!..updateVerbs(verbViewModel.verbs),
      child: QuizScreen(),
    ),
    ChangeNotifierProxyProvider<VerbViewModel, SearchViewModel>(
      create: (_) => SearchViewModel(),
      update: (_, verbViewModel, searchViewModel) => searchViewModel!..updateVerbs(verbViewModel.verbs),
      child: VerbScreen(),
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
