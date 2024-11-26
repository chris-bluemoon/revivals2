import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

/// A utility method to open WhatsApp on different devices
/// Optionality you can add [text] message
Future<void> openLineApp({
  required String phone,
  String? text,
  LaunchMode mode = LaunchMode.externalApplication,
}) async {
  final String textIOS = text != null ? Uri.encodeFull('?text=$text') : '';
  final String textAndroid = text != null ? Uri.encodeFull('&text=$text') : '';

  // https://line.me/R/
  // https://liff.line.me/
  final String urlIOS = 'https://wa.me/$phone$textIOS';
  final String urlAndroid = 'liff.line.me:://send/?phone=$phone$textAndroid';

  String effectiveURL = Platform.isIOS ? urlIOS : urlAndroid;
  // effectiveURL = 'https://line.me/R/';
  // effectiveURL2 = 'https://line.me/R/oaMessage/ZnlhXmE';
  // effectiveURL = 'https://liff.line.me/';
  effectiveURL = 'http://line.me/ti/p/~chris-mbfc';
  effectiveURL = 'http://line.me/ti/p/~isabellachsz';
  effectiveURL = 'http://line.me/ti/p/@447qtapp';
  // effectiveURL = 'http://line.me/ti/p/~UnearthedCollections';
  // effectiveURL = 'https://line.me/R/oaMessage/@chris-mbfc/?Hello';

  if (await canLaunchUrl(Uri.parse(effectiveURL))) {
    await launchUrl(Uri.parse(effectiveURL));
  } else {
    throw Exception('openLineApp could not launching url: $effectiveURL');
  }
}