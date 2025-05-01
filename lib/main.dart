import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/theme.dart';
import 'presentation/home_screen.dart';
import 'domain/service/verb_view_model.dart';
import 'data/shared_preference_manager.dart';

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
      themeMode: ThemeMode.system,
      theme: ThemeData(
          colorScheme: schemeLight,
      ),
      darkTheme: ThemeData(
          colorScheme: schemeDark,
      ),
      home: ChangeNotifierProvider(
        create: (_) => VerbViewModel(),
        child: HomeScreen(),
      ),
    );
  }
}
