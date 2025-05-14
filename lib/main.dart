import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/service/history_service.dart';
import 'domain/service/verb_service.dart';
import 'presentation/theme.dart';
import 'presentation/home_screen.dart';
import 'domain/service/shared_preference_service.dart';

void main() => runApp(const MyApp());

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
        dividerTheme: DividerThemeData(
          color: schemeLight.surfaceDim,
        ),
      ),
      darkTheme: ThemeData(
          colorScheme: schemeDark,
          dividerTheme: DividerThemeData(
            color: schemeDark.surfaceBright,
          ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          linearTrackColor: schemeDark.primaryContainer,
        ),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => HistoryService(),
          ),
          ChangeNotifierProvider(
            create: (_) => VerbService(),
          ),
          ChangeNotifierProvider(
            create: (_) => SharedPreferenceService(),
          ),
        ],
        child: HomeScreen(),
      ),
    );
  }
}
