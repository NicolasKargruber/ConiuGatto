import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
  }

  static sendMailToRequestVerb(String verb){
    final Uri emailURI = Uri(
      scheme: 'mailto',
      path: 'nicolas.kargruber.dev@gmail.com',
      query: _encodeQueryParameters(<String, String>{
        'subject': 'Request Verb - $verb',
        'body': 'Hey Nicolas,\n\nI would like to request the following verb "$verb".\n\nThanks!'
      }),
    );

    launchUrl(emailURI);
  }
}