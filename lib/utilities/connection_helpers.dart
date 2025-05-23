import 'dart:io';

// Check for internet connection
Future<bool> hasInternet() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException {
    return false;
  }
}