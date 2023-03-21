import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/models/weather_model.dart';
import 'package:weather/core/resources/environment.dart';

class WeatherProvider extends ChangeNotifier {
  List<double>? _currentLocation;
  List<double> get currentLocation => _currentLocation ?? defaultLocation;
  set currentLocation(List<double> value) {
    _currentLocation = value;
    notifyListeners();
  }

  WeatherModel? _weatherModel;
  WeatherModel? get weatherModel => _weatherModel;

  void initialize(BuildContext context) {
    fetchCurrentLocation(context);
  }

  /// 获取当前经纬度并请求天气
  Future fetchCurrentLocation(BuildContext context) async {
    if (await _checkPermission()) {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((value) => [value.latitude, value.longitude])
          .then((value) {
        _currentLocation = value;
        loadWeather(context);
      }).catchError((e) {
        loadWeather(context);
      });
      notifyListeners();
    } else {
      if (context.mounted) {
        loadWeather(context);
      }
    }
  }

  /// 检查定位权限
  Future<bool> _checkPermission([bool requested = false]) async {
    var serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      Fluttertoast.showToast(msg: '定位服务不可用');
      return false;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) return false;
    if (permission == LocationPermission.denied) {
      if (requested) return false;
      permission = await Geolocator.requestPermission();
      return _checkPermission(true);
    } else {
      return true;
    }
  }

  /// 请求天气
  void loadWeather(BuildContext context) async {
    // 请求实时天气
    notifyListeners();
  }

  static WeatherProvider read(BuildContext context) => context.read();
  static WeatherProvider watch(BuildContext context) => context.watch();
}
