import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/providers/weather_provider.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/ui/components/animated_background.dart';
import 'package:weather/core/models/weather_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, value, child) {
        WeatherModel? weatherModel = value.weatherModel;
        return Container(
          decoration: BoxDecoration(
              gradient: backgroundWeatherTheme(context).background),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              fit: StackFit.expand,
              children: [AnimatedBackground(WeatherType.sunnyNight)],
            ),
          ),
        );
      },
    );
  }
}
