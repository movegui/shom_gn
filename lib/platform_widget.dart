import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformWidget extends StatelessWidget {
  final Widget android;
  final Widget ios;
  final Widget web;

  const PlatformWidget({
    super.key,
    required this.android,
    required this.ios,
    required this.web,
  });

  static bool isAndroid(BuildContext context) {
     return !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  }

  static bool isIos(BuildContext context) {
     return !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;
  }

  static bool isWeb(BuildContext context) => kIsWeb == true;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return android;
    }
    else if (Platform.isIOS) {
      return ios;
    }
    else {
      return web;
    }
  }
}
