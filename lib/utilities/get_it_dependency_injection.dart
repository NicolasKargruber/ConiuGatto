import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../data/utils/verb_data_source.dart';
import '../domain/service/history_service.dart';
import '../domain/service/shared_preference_service.dart';
import '../domain/service/verb_service.dart';

void setupDependencyInjection() {
  // DataSource
  GetIt.I.registerLazySingleton<VerbDataSource>(() => VerbDataSource());
  // Helpers
  GetIt.I.registerSingleton<LocalVerbsFile>(LocalVerbsFile());
  GetIt.I.registerSingleton<http.Client>(http.Client());
  // Services
  GetIt.I.registerSingleton<SharedPreferenceService>(SharedPreferenceService());
}