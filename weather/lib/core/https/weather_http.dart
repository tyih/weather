import 'package:weather/core/https/http_connection.dart';
import 'package:weather/core/models/weather_model.dart';
import 'package:weather/core/resources/environment.dart';

class WeatherHttp {
  HttpConnection connection = HttpConnection();
  Future<WeatherModel?> getWeather(
      {required double lat, required double lon}) async {
    final response = await connection.get('weather/now', params: {
      'key': key,
      'location': '$lat,$lon',
      'lang': 'zh',
      'unit': 'm'
    });
    if (response != null) {
      return WeatherModel.fromJson(response);
    } else {
      return null;
    }
  }
}
