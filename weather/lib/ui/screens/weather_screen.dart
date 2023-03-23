import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:glass/glass.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/providers/weather_provider.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/ui/components/animated_background.dart';
import 'package:weather/core/models/weather_model.dart';
import 'package:weather/ui/components/custom_divider.dart';

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
              children: [
                AnimatedBackground(WeatherType.sunnyNight),
                if (weatherModel != null)
                  SafeArea(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () => WeatherProvider.read(context)
                                    .fetchCurrentLocation(context),
                                icon: const Icon(Icons.gps_fixed,
                                    color: Colors.white)),
                            Expanded(
                              child: Text(
                                weatherModel.address ?? "NULL",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(color: Colors.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                                onPressed: () => WeatherProvider.read(context)
                                    .loadWeather(context),
                                icon: const Icon(Icons.refresh,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 20),
                          children: [
                            _weatherDetail(context, weatherModel),
                            const ColumnDivider(space: 20),
                            GridView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.5,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10),
                                children: [
                                  _boxItemWidget(
                                    Icons.wind_power,
                                    "风",
                                    "${weatherModel.now.windSpeed} m/s",
                                    "风力等级 : ${weatherModel.now.windScale}°",
                                  ),
                                  _boxItemWidget(
                                    Icons.thermostat,
                                    "温度",
                                    "${weatherModel.now.temp}°C",
                                    "体感温度 : ${weatherModel.now.feelsLike}°C",
                                  ),
                                  _boxItemWidget(
                                    Icons.water_drop,
                                    "相对湿度",
                                    "${weatherModel.now.humidity}%",
                                    "大气压强 : ${weatherModel.now.pressure} hPa",
                                  ),
                                  _boxItemWidget(
                                    Icons.cloud,
                                    "云量",
                                    "${weatherModel.now.cloud}%",
                                    "能见度 : ${weatherModel.now.vis} km",
                                  )
                                ])
                          ],
                        ),
                      ),
                    ],
                  ))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _weatherDetail(BuildContext context, WeatherModel weatherModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(children: [
        Text("${weatherModel.now.temp}°",
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: Colors.white)),
        const ColumnDivider(space: 3),
        Text('MAIN',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        const ColumnDivider(space: 5),
        Text("T:${10}° R:${15}°",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white)),
      ]),
    );
  }

  Widget _boxItemWidget(IconData icon, String title, String value,
      [String? subtitle]) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.grey.shade300, size: 15),
              const RowDivider(space: 5),
              Expanded(
                  child: Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.grey.shade300))),
            ],
          ),
          const ColumnDivider(space: 5),
          Expanded(
              child: Text(value,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold))),
          if (subtitle != null)
            Text(subtitle,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.white))
        ],
      ),
    ).asGlass(clipBorderRadius: BorderRadius.circular(10));
  }
}
