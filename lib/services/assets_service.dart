import 'dart:convert';
import 'package:flutter/services.dart';

class AssetsService {
  static late String apiKey;
  static late String baseUrl;

  static Future<void> loadConfig() async {
    final String response = await rootBundle.loadString('assets/config.json');
    final data = await json.decode(response);
    apiKey = data['apiKey'];
    baseUrl = data['baseUrl'];
  }
}
