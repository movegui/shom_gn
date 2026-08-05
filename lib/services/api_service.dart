import 'package:dio/dio.dart';
import 'package:shom_gn/config/env.dart';

class ApiService {
  final Env env;
  final String currency;
  final Dio dio;

  ApiService({required this.env, required this.currency, required this.dio}) {
  //  dio = Dio(BaseOptions(baseUrl: env.baseUrl));

    if (env.enableLogs) {
      print('🌍 API => ${env.apiUrl}');
    }
  }
}
