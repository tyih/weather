import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:weather/core/resources/colors.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  late ThemeWeather themeWeather;

  @override
  void initState() {
    themeWeather = backgroundWeatherTheme(context);
    // 渲染结束回调
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('hello'),
    );
  }
}
