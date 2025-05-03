import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/service/verb_service.dart';
import 'presentation/theme.dart';
import 'presentation/home_screen.dart';
import 'domain/service/shared_preference_service.dart';

// TODO Use GetIt for Dependency Injection
late SharedPreferenceService preferenceManager;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferenceManager = SharedPreferenceService();
  await preferenceManager.initializationFuture;
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
        dividerTheme: DividerThemeData(
          color: schemeLight.surfaceDim,
        ),
      ),
      darkTheme: ThemeData(
          colorScheme: schemeDark,
          dividerTheme: DividerThemeData(
            color: schemeDark.surfaceBright,
          ),
      ),
      home: ChangeNotifierProvider(
        create: (_) => VerbService(),
        child: HomeScreen(),
      ),
    );
  }
}
