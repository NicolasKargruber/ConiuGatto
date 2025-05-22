import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../data/utils/verb_data_source.dart';

void setupDependencyInjection() {
  GetIt.I.registerLazySingleton<VerbDataSource>(() => VerbDataSource());
  GetIt.I.registerSingleton<LocalVerbsFile>(LocalVerbsFile());
  GetIt.I.registerSingleton<http.Client>(http.Client());
}