import 'package:purchases_flutter/purchases_flutter.dart';

class StoreConfig {
  final Store store;
  final String apiKey;
  static StoreConfig? _instance;

  factory StoreConfig({required Store store, required String apiKey}) {
    _instance ??= StoreConfig._internal(store, apiKey);
    return _instance!;
  }

  StoreConfig._internal(this.store, this.apiKey);

  static StoreConfig get instance => _instance!;

  static bool isForAppleStore() => instance.store == Store.appStore || instance.store == Store.macAppStore;

  static bool isForGooglePlay() => instance.store == Store.playStore;
}