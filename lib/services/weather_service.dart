import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

//Service to get the weather info based on the current location
class WeatherService {
  //static const String _apiKey = '497228a407f5892bd8f326e98c5613fb';
  static const String _apiKey = '401b0407789fe4959aa867b03aa23e35';
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> fetchWeather(double lat, double lon) async {
    final url = '$_baseUrl?lat=$lat&lon=$lon&units=metric&appid=$_apiKey';
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
