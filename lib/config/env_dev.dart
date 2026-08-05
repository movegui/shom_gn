

import 'package:shom_gn/config/env.dart';

class EnvDev extends Env {

  @override
  String get apiUrl => "http://127.0.0.1";

  @override
  bool get enableLogs => true;
  
  @override
  AppEnv get currentEnv => AppEnv.dev;
  
  @override
  String get port => "5001";
  


}