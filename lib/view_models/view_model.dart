import 'package:flutter/foundation.dart';

abstract class ViewModel extends ChangeNotifier{
  bool _isInitialized = false;
  late Future initializationFuture;
  bool get isInitialized => _isInitialized;

  ViewModel(){
    _isInitialized = false;
    initializationFuture = initialize();
    initializationFuture.then((_) => _isInitialized = true);
    notifyListeners();
  }

  Future initialize();

  bool _isLoading = false;
  bool get isLoading => _isLoading /*|| currentFuture != null*/;

  //Future? currentFuture;

  toggleLoading(){
    _isLoading = !_isLoading;
    notifyListeners();
  }
}