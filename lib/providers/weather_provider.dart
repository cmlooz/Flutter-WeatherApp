import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_service.dart';

//Provider to access the location and weather services
class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  final WeatherService _weatherService = WeatherService();

  Weather? get weather => _weather;
  //Function to call the custom weather service with the current location
  Future<void> fetchWeather() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _weather = await _weatherService.fetchWeather(
        position.latitude, position.longitude);
    notifyListeners();
  }
}
