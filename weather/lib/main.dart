import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/providers/weather_provider.dart';
import 'package:weather/ui/screens/main_screen.dart';
import 'package:weather/ui/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeatherProvider>(
        create: (context) => WeatherProvider()..initialize(context),
        builder: (context, child) => const MaterialApp(
              title: 'Weather',
              debugShowCheckedModeBanner: false,
              home: Root(),
            ));
  }
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  bool _ready = false;

  @override
  void initState() {
    _ready = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _ready ? const MainScreen() : const SplashScreen();
  }
}
