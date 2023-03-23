import 'package:weather/core/https/http_connection.dart';
import 'package:weather/core/models/geo_model.dart';
import 'package:weather/core/resources/environment.dart';

class GeoHttp {
  HttpConnection connection = HttpConnection(baseUrl: geoBaseUrl);
  Future<GeoModel?> getGeoInfo(
      {required double lat, required double lon}) async {
    final response = await connection.get('city/lookup', params: {
      'key': key,
      'location': '$lat,$lon',
      'lang': 'zh',
    });
    if (response != null) {
      return GeoModel.fromJson(response);
    } else {
      return null;
    }
  }
}
