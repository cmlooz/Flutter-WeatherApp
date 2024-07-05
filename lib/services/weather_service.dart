import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/assets_service.dart';

//Service to get the weather info based on the current location
class WeatherService {
  Future<Weather> fetchWeather(double lat, double lon) async {
    await AssetsService.loadConfig();
    final url =
        '${AssetsService.baseUrl}?lat=$lat&lon=$lon&units=metric&appid=${AssetsService.apiKey}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      String message = jsonMap['message'];
      throw Exception(message);
    }
  }
}
