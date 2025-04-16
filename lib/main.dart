import 'screens/home_screen.dart';
import 'view_models/verb_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utilities/shared_preference_manager.dart';

// TODO Use GetIt for Dependency Injection
late SharedPreferenceManager preferenceManager;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferenceManager = await SharedPreferenceManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: ChangeNotifierProvider(
        create: (_) => VerbViewModel(),
        child: HomeScreen(),
      ),
    );
  }
}
