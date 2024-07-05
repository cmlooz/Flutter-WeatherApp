import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:permission_handler/permission_handler.dart';

//Weather info Page
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late PermissionStatus _status;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  //check if the location permission is granted
  Future<void> _checkPermission() async {
    PermissionStatus status = await Permission.locationWhenInUse.status;
    setState(() {
      _status = status;
    });

    if (_status == PermissionStatus.denied) _requestPermission();
  }

  //Ask for the permission to the user
  Future<void> _requestPermission() async {
    PermissionStatus status = await Permission.locationWhenInUse.request();
    setState(() {
      _status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather', style: style.copyWith(fontSize: 30)),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: FutureBuilder(
        future:
            Provider.of<WeatherProvider>(context, listen: false).fetchWeather(),
        builder: (ctx, snapshot) {
          //Loading while fetching data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          //If there is any error
          else if (snapshot.error != null) {
            return Center(child: Text(snapshot.error.toString()));
          }
          //Show temperature and weather info
          else {
            return Consumer<WeatherProvider>(
              builder: (ctx, weatherProvider, child) => Center(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      BigCard(
                          text: weatherProvider.weather?.main ?? '',
                          icon: weatherProvider.weather?.icon ?? ''),
                      const SizedBox(height: 10),
                      Text(
                        'Temperature: ${weatherProvider.weather?.temperature ?? 'N/A'} °C',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

//Component to show weather info
class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final String text;
  final String icon;

  String _getWeatherIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          // Make sure that the compound word wraps correctly when the window
          // is too narrow.
          child: Wrap(
            children: [
              Image.network(
                _getWeatherIconUrl(icon),
                width: 100,
                height: 100,
                // You can add more properties like fit, alignment, etc.
              ),
              Text(
                text,
                style: style.copyWith(fontWeight: FontWeight.w200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
