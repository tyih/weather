import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/core/utils/extensions.dart';
import 'package:weather/ui/components/animated_background.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  WeatherType weatherType = WeatherType.sunny;
  late ThemeWeather themeWeather;

  @override
  void initState() {
    themeWeather = backgroundWeatherTheme(context);
    // 渲染结束回调
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      randomAnimation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: themeWeather.background),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            children: [
              FloatingActionButton(
                heroTag: "change_background",
                onPressed: () => randomBackground(),
                child: const Icon(Icons.format_paint),
              ),
              const Spacer(),
              FloatingActionButton(
                heroTag: "change_animation",
                onPressed: () => randomAnimation(),
                child: const Icon(Icons.animation),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            AnimatedBackground(weatherType, themeWeather: themeWeather),
            SafeArea(
              child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SafeArea(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              "Search Location",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            const Positioned(
                                left: 0,
                                width: 30,
                                child: CloseButton(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                            top: 10,
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 30,
                            left: 20,
                            right: 20),
                        child: const Text('Search Location'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ).dismissKeyboardOnTap(context),
    );
  }

  void randomBackground() {
    setState(() {
      themeWeather = weatherThemes[Random().nextInt(gradients.length)];
    });
  }

  void randomAnimation() {
    setState(() {
      weatherType =
          WeatherType.values[Random().nextInt(WeatherType.values.length)];
    });
  }
}
