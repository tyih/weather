import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';

import 'package:weather/core/resources/colors.dart';
import 'package:weather/core/utils/utils.dart';

class AnimatedBackground extends StatelessWidget {
  final WeatherType? weatherType;
  final ThemeWeather? themeWeather;
  const AnimatedBackground(
    this.weatherType, {
    Key? key,
    this.themeWeather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeWeather skyGradient = themeWeather ?? backgroundWeatherTheme(context);
    var weatherType = this.weatherType;
    if (alreadyNight) {
      if (weatherType == WeatherType.sunny) {
        weatherType = WeatherType.sunnyNight;
      }
      if (weatherType == WeatherType.cloudy) {
        weatherType = WeatherType.cloudyNight;
      }
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        if (weatherType != null)
          Opacity(
            opacity: .5,
            child: WeatherBg(
                weatherType: weatherType,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height),
          ),
        if (weatherType == WeatherType.sunnyNight)
          Opacity(
              opacity: .5,
              child: Image.asset('assets/images/aurora.png',
                  height: MediaQuery.of(context).size.height / 1.5,
                  fit: BoxFit.cover)),
        Positioned(
            bottom: 0,
            height: MediaQuery.of(context).size.height,
            child: ShaderMask(
              shaderCallback: const LinearGradient(
                      colors: [Colors.transparent, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)
                  .createShader,
              child: Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(gradient: skyGradient.background),
                child: Image.asset('assets/images/deer.png',
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    color: skyGradient.deerColor),
              ),
            ))
      ],
    );
  }
}
