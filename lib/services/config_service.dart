import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shom_gn/models/footer_config_model.dart';

Future<FooterConfigModel> loadFooterConfig() async {
  final jsonString =
      await rootBundle.loadString('assets/config/info.json');

  final data = json.decode(jsonString);
  print('the config is: $data');

  return FooterConfigModel.fromJson(data);
}