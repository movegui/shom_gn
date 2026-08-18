import 'dart:io';

import 'package:flutter/foundation.dart';

class MyPlatform {
  static PlatformEnum getCurrentPlatform() {
    if (kIsWeb) return PlatformEnum.web;

    if (!kIsWeb && Platform.isAndroid || !kIsWeb && Platform.isIOS) {
      return PlatformEnum.sdk;
    }

    return PlatformEnum.desktop;
  }
}

enum PlatformEnum { sdk, web, desktop }
