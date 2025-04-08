import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading /*|| currentFuture != null*/;

  //Future? currentFuture;

  toggleLoading(){
    _isLoading = !_isLoading;
    notifyListeners();
  }
}