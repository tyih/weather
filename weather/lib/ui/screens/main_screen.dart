import 'package:flutter/material.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/core/utils/navigations.dart';
import 'package:weather/ui/screens/search_location_screen.dart';
import 'package:weather/ui/screens/weather_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWeatherTheme(context).deerColor,
      body: Column(
        children: [
          const Expanded(child: WeatherScreen()),
          Divider(height: 0, color: Colors.white.withOpacity(.2)),
          _bottomWidget(context)
        ],
      ),
    );
  }

  Widget _bottomWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: SafeArea(
          top: false,
          child: Row(
            children: [_titleExpanded, _searchButton],
          )),
    );
  }

  Expanded get _titleExpanded => Expanded(
      child: Text('Powered by QWeather',
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.white)));

  TextButton get _searchButton => TextButton(
      style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.white.withOpacity(.2),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: () => startScreen(context, const SearchLocationScreen()),
      child: const Text('Search'));
}
