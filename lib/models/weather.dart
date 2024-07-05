//Model to select only the specified fields from the weather API
class Weather {
  final double temperature;
  final String main;
  final String icon;
  Weather({required this.temperature, required this.main, required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    double temperature = json['main']['temp'];
    String main = json['weather'][0]['main'];
    String icon = json['weather'][0]['icon'];
    return Weather(temperature: temperature, main: main, icon: icon);
  }
}
