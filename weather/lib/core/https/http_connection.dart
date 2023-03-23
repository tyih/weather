import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather/core/models/model.dart';
import 'package:weather/core/resources/environment.dart';
import 'package:weather/core/utils/logger.dart';

class HttpConnection {
  final String? baseUrl;

  HttpConnection({this.baseUrl});

  Dio get _dio => Dio(BaseOptions(baseUrl: baseUrl ?? weatherBaseUrl, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }));

  Future get(String url, {Map<String, String>? params, dynamic headers}) async {
    try {
      headers = _preRequest(headers);

      var resp = await _dio.get(url + paramsToString(params),
          options: Options(headers: headers));
      if (resp.data['code'] != '200') {
        Fluttertoast.showToast(msg: '请求失败 realUri>${resp.realUri}');
        return null;
      }
      Fluttertoast.showToast(
          msg: 'realUri>${resp.realUri}', timeInSecForIosWeb: 5);
      cprint('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${resp.realUri}');
      return resp.data;
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      return null;
    }
  }

  Future post(String url,
      {Map<String, String>? params, dynamic body, dynamic headers}) async {
    try {
      headers = _preRequest(headers);

      var resp = await _dio.post(url + paramsToString(params),
          data: body, options: Options(headers: headers));

      return resp.data;
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      return null;
    }
  }

  Future put(String url,
      {Map<String, String>? params, dynamic body, dynamic headers}) async {
    try {
      headers = _preRequest(headers);
      var resp = await _dio.put(url + paramsToString(params),
          data: body, options: Options(headers: headers));
      return resp.data;
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      return null;
    }
  }

  Future delete(String url,
      {Map<String, String>? params, dynamic body, dynamic headers}) async {
    try {
      headers = _preRequest(headers);
      var resp = await _dio.delete(url + paramsToString(params),
          data: body, options: Options(headers: headers));
      return resp.data;
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      return null;
    }
  }

  Map<String, String>? _preRequest(Map<String, String>? headers) {
    return headers;
  }

  static String paramsToString(Map<String, String>? params) {
    if (params == null) return '';
    String output = '?';
    params.forEach((key, value) {
      output += '$key=$value&';
    });
    return output.substring(0, output.length - 1);
  }
}

class ApiResponse<T> extends Model {
  ApiResponse({this.success = false, this.message, this.data});

  bool? success;
  String? message;
  T? data;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
      success: json['success'], message: json['message'], data: json['data']);

  @override
  Map<String, dynamic> toJson() =>
      {'success': success, 'message': message, 'data': data};
}
