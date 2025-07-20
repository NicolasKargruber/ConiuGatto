import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'domain/service/billing_service.dart';
import 'domain/service/history_service.dart';
import 'domain/service/in_app_review_service.dart';
import 'domain/service/package_info_service.dart';
import 'domain/service/shared_preference_service.dart';
import 'domain/service/verb_service.dart';
import 'l10n/app_localizations.dart';
import 'presentation/introduction/screens/splash_screen.dart';
import 'presentation/introduction/view_models/splash_view_model.dart';
import 'presentation/theme.dart';
import 'utilities/get_it_dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ConiuGatto",
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: [
        Locale('en'), // English
        Locale('de'), // German
        //Locale('it'), // Italian
        //Locale('es'), // Spanish
      ],
      themeMode: ThemeMode.system,
      theme: ThemeData(colorScheme: schemeLight, dividerTheme: DividerThemeData(color: schemeLight.surfaceDim)),
      darkTheme: ThemeData(
        colorScheme: schemeDark,
        dividerTheme: DividerThemeData(color: schemeDark.surfaceBright),
        progressIndicatorTheme: ProgressIndicatorThemeData(linearTrackColor: schemeDark.primaryContainer),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HistoryService()),
          ChangeNotifierProvider(create: (_) => VerbService()),
          ChangeNotifierProvider.value(value: GetIt.I<SharedPreferenceService>()),
          ChangeNotifierProvider(create: (_) => SplashViewModel(GetIt.I<SharedPreferenceService>())),
          ChangeNotifierProvider(create: (_) => PackageInfoService()),
          ChangeNotifierProvider(create: (_) => InAppReviewService(GetIt.I<SharedPreferenceService>())),
          ChangeNotifierProvider(create: (_) => BillingService()),
        ],
        child: SplashScreen(),
      ),
    );
  }
}
