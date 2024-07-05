import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/login_screen.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:weather_app/providers/auth_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<AuthProvider>(
          builder: (context, auth, _) {
            return auth.isAuthenticated
                ? const WeatherScreen()
                : const LoginScreen();
          },
        ),
      ),
    );
  }
}
