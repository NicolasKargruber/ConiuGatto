import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../utils/store_config.dart';
import 'service.dart';

class BillingService extends Service {
  final _logTag = (BillingService).toString();

  // Store API Keys
  static const _appStoreApiKey = 'appl_jzFaRdCemMgewQSinbJNWGOydyP';
  static const _playStoreApiKey = 'goog_WedbVnvfofxljvPhwzVRAHOTRnV';

  // Product IDs
  static const _smallCoffeeID = 'small_coffee';
  static const _mediumCoffeeID = 'medium_coffee';
  static const _largeCoffeeID = 'large_coffee';
  static const List<String> _productIds = [_smallCoffeeID, _mediumCoffeeID, _largeCoffeeID];

  bool get isFetchingProducts => isLoading;

  // Products
  Set<StoreProduct> _productList = {};
  List<StoreProduct> get productList => [..._productList];

  @override
  Future<void> initialize() async {
    debugPrint("$_logTag | initialize()");
    if (Platform.isIOS || Platform.isMacOS) {
      StoreConfig(store: Store.appStore, apiKey: _appStoreApiKey);
    } else if (Platform.isAndroid) {
      StoreConfig(store: Store.playStore, apiKey: _playStoreApiKey);
    }

    await _configureSDK();
    await getProducts();
  }

  Future<void> _configureSDK() async {
    await Purchases.setLogLevel(LogLevel.debug);
    PurchasesConfiguration configuration = PurchasesConfiguration(StoreConfig.instance.apiKey);
    configuration.entitlementVerificationMode = EntitlementVerificationMode.informational;
    configuration.pendingTransactionsForPrepaidPlansEnabled = true;
    await Purchases.configure(configuration);
    await Purchases.enableAdServicesAttributionTokenCollection();
  }

  Future<void> getProducts() async {
    if(isLoading) return;
    debugPrint("$_logTag | getProducts()");
    toggleLoading();

    _productList.addAll(await Purchases.getProducts(_productIds, productCategory: ProductCategory.nonSubscription));
    final sorted = _productList.sorted((a, b) => a.price.compareTo(b.price));
    if(!ListEquality().equals(sorted, _productList.toList())) _productList = sorted.toSet();

    toggleLoading();
    debugPrint("$_logTag | getProducts() | productList: $_productList");
  }

  Future<void> purchaseProduct(StoreProduct product) async {
    debugPrint("$_logTag | purchaseProduct()");
    debugPrint("$_logTag | product: ${product.title}");
    Purchases.purchaseStoreProduct(product);
  }
}