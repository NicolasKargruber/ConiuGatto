import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'domain/service/history_service.dart';
import 'domain/service/package_info_service.dart';
import 'domain/service/verb_service.dart';
import 'presentation/introduction/screens/on_boarding_screen.dart';
import 'presentation/introduction/screens/splash_screen.dart';
import 'presentation/introduction/view_models/splash_view_model.dart';
import 'presentation/theme.dart';
import 'presentation/home_screen.dart';
import 'domain/service/shared_preference_service.dart';
import 'utilities/app_values.dart';
import 'utilities/extensions/build_context_extensions.dart';
import 'utilities/get_it_dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjection();
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
        ],
        child: SplashScreen(),
      ),
    );
  }
}
