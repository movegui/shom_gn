

import 'package:shom_gn/config/env.dart';

class Environment {
  static const String envName = String.fromEnvironment(
    'ENV',
    defaultValue: 'dev',
  );

  static AppEnv get current {
    switch (envName) {
      case 'prod':
        return AppEnv.prod;

      case 'test':
        return AppEnv.test;

      default:
        return AppEnv.dev;
    }
  }

  static bool get isDev => current == AppEnv.dev;

  static bool get isTest => current == AppEnv.test;

  static bool get isProd => current == AppEnv.prod;
}