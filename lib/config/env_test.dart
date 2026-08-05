

import 'package:shom_gn/config/env.dart';

class EnvTest extends Env {
  @override
  String get apiUrl => "https://test.movegui.com";

  @override
  bool get enableLogs => true;
  
  @override
  AppEnv get currentEnv => AppEnv.test;
  
  @override
  String get port => "5000";
  
  
}