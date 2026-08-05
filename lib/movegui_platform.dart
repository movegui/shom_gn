import 'dart:io';

import 'package:flutter/foundation.dart';

class MoveguiPlatform {
  static MoveGuiPlatformEnum getCurrentPlatform() {
    if (kIsWeb) return MoveGuiPlatformEnum.WEB;

    if (!kIsWeb && Platform.isAndroid || !kIsWeb && Platform.isIOS) {
      return MoveGuiPlatformEnum.SDK;
    }

    return MoveGuiPlatformEnum.DESKTOP;
  }
}

enum MoveGuiPlatformEnum { SDK, WEB, DESKTOP }
