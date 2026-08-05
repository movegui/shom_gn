
enum AppEnv {
  dev,
  test,
  prod,
}

abstract class Env {
  String get apiUrl;
  bool get enableLogs;
  AppEnv get currentEnv;
  String get port;
    String get baseUrl =>
      '$apiUrl:$port';
}