abstract class Service {
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  late Future initializationFuture;

  Service(){
    _isInitialized = false;
    initializationFuture = initialize();
    initializationFuture.then((_) => _isInitialized = true);
  }

  // Initialize => TO BE OVERRIDDEN
  Future initialize();
}