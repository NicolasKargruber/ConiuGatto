import 'package:flutter/foundation.dart';

final _logTag = (ViewModel).toString();

abstract class ViewModel extends ChangeNotifier {
  // Initialize
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  late Future initializationFuture;

  // Loading
  bool _isLoading = false;
  bool get isLoading => _isLoading || !_isInitialized;

  ViewModel(){
    _isInitialized = false;
    initializationFuture = initialize();
    initializationFuture.then((_) => _isInitialized = true);
    notifyListeners();
  }

  // Initialize => TO BE OVERRIDDEN
  Future initialize();

  // Loading
  toggleLoading(){
    _isLoading = !_isLoading;
    notifyListeners();
  }
}