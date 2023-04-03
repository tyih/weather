import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';
import 'package:weather/core/models/weather_model.dart';

extension KeyboardDismisser on Widget {
  Widget dismissKeyboardOnTap(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: this,
    );
  }
}

extension WeatherTypeModel on WeatherModel {
  WeatherType get weatherType {
    int iconId = int.parse(now.icon);
    if (iconId >= 300 && iconId <= 399) return WeatherType.middleRainy;
    if (iconId >= 400 && iconId <= 499) return WeatherType.middleSnow;
    if (iconId >= 500 && iconId <= 515) return WeatherType.dusty;
    switch (iconId) {
      case 100:
        return WeatherType.sunny;
      case 150:
        return WeatherType.sunny;
      case 101:
        return WeatherType.cloudy;
      case 102:
        return WeatherType.cloudy;
      case 103:
        return WeatherType.cloudy;
      case 151:
        return WeatherType.cloudy;
      case 152:
        return WeatherType.cloudy;
      case 153:
        return WeatherType.cloudy;
      case 104:
        return WeatherType.overcast;
    }
    return WeatherType.sunny;
  }
}
