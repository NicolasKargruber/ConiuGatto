import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static sendMailToRequestVerb(String verb) {
    _launchUrlWithParameters({
      'subject': 'Request Verb | $verb',
      'body': 'Hey Nicolas,\n\nI would like to request the following verb "$verb".\n\nThanks!'
    });
  }

  static sendMailToReportSolution(String verb, String tense, String solution) {
    _launchUrlWithParameters({
      'subject': 'Report Issue | $solution',
      'body': 'Hey Nicolas,\n\n'
          'I would like to report an issue with the following solution "$solution".\n\n'
          'Verb: $verb\n'
          'Tense: $tense\n\n'
          'Thanks!'
    });
  }

  static sendMailToReportConjugation(String verb, String tense) {
    _launchUrlWithParameters({
      'subject': 'Report Issue | $verb',
      'body': 'Hey Nicolas,\n\n'
          'I would like to report an issue for the following verb "$verb".\n\n'
          'Verb: $verb\n'
          'Tense: $tense\n\n'
          'Conjugation: -> INSERT HERE <-\n\n'
          'Thanks!'
    });
  }

  static _launchUrlWithParameters(Map<String, String> parameters) {
    final Uri emailURI = Uri(
      scheme: 'mailto',
      path: 'nicolas.kargruber.dev@gmail.com',
      query: _encodeQueryParameters(parameters),
    );

    launchUrl(emailURI);
  }

  static String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
  }
}