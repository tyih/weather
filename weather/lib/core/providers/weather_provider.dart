import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/https/geo_http.dart';
import 'package:weather/core/https/weather_http.dart';
import 'package:weather/core/models/geo_model.dart';
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
      // 获取经纬度
      LocationData locationData = await Location().getLocation();
      if (locationData.latitude != null && locationData.longitude != null) {
        _currentLocation = [locationData.longitude!, locationData.latitude!];
      }
      if (context.mounted) {
        loadWeather(context);
      }
    } else {
      if (context.mounted) {
        loadWeather(context);
      }
    }
  }

  /// 检查定位权限
  Future<bool> _checkPermission() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // 判断是否启用了位置服务
    serviceEnabled = await location.serviceEnabled(); // 检查设备位置是否已启用
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService(); // 提示用户启用位置
      if (!serviceEnabled) {
        Fluttertoast.showToast(msg: '设备定位未开启');
        return false;
      }
    }

    // 检查此应用是否具有使用它的权限
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      // 定位服务权限被拒绝
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        // 定位服务权限未被授予
        Fluttertoast.showToast(msg: '此应用定位未开启');
        return false;
      }
    }
    return true;
  }

  Future<String?> _getAddress(double? lat, double? lon) async {
    if (lat == null || lon == null) return null;
    GeoModel? geoModel = await GeoHttp().getGeoInfo(lat: lat, lon: lon);
    return geoModel?.location[0].name;
  }

  /// 请求天气
  void loadWeather(BuildContext context) async {
    // 请求实时天气
    WeatherHttp()
        .getWeather(lat: currentLocation.first, lon: currentLocation.last)
        .then((value) async {
      _weatherModel = value;
      String? address =
          await _getAddress(currentLocation.first, currentLocation.last);
      _weatherModel?.address = address;
      notifyListeners();
    });
  }

  static WeatherProvider read(BuildContext context) => context.read();
  static WeatherProvider watch(BuildContext context) => context.watch();
}
