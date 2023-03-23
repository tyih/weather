import 'dart:convert';

WeatherModel weatherModelFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  WeatherModel({
    required this.code,
    required this.updateTime,
    required this.fxLink,
    required this.now,
    required this.refer,
  });

  String code;
  String updateTime;
  String fxLink;
  Now now;
  Refer refer;
  String? address;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        code: json["code"],
        updateTime: json["updateTime"],
        fxLink: json["fxLink"],
        now: Now.fromJson(json["now"]),
        refer: Refer.fromJson(json["refer"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "updateTime": updateTime,
        "fxLink": fxLink,
        "now": now.toJson(),
        "refer": refer.toJson(),
      };
}

class Now {
  Now({
    required this.obsTime,
    required this.temp,
    required this.feelsLike,
    required this.icon,
    required this.text,
    required this.wind360,
    required this.windDir,
    required this.windScale,
    required this.windSpeed,
    required this.humidity,
    required this.precip,
    required this.pressure,
    required this.vis,
    required this.cloud,
    required this.dew,
  });

  String obsTime;
  String temp;
  String feelsLike;
  String icon;
  String text;
  String wind360;
  String windDir;
  String windScale;
  String windSpeed;
  String humidity;
  String precip;
  String pressure;
  String vis;
  String cloud;
  String dew;

  factory Now.fromJson(Map<String, dynamic> json) => Now(
        obsTime: json["obsTime"],
        temp: json["temp"],
        feelsLike: json["feelsLike"],
        icon: json["icon"],
        text: json["text"],
        wind360: json["wind360"],
        windDir: json["windDir"],
        windScale: json["windScale"],
        windSpeed: json["windSpeed"],
        humidity: json["humidity"],
        precip: json["precip"],
        pressure: json["pressure"],
        vis: json["vis"],
        cloud: json["cloud"],
        dew: json["dew"],
      );

  Map<String, dynamic> toJson() => {
        "obsTime": obsTime,
        "temp": temp,
        "feelsLike": feelsLike,
        "icon": icon,
        "text": text,
        "wind360": wind360,
        "windDir": windDir,
        "windScale": windScale,
        "windSpeed": windSpeed,
        "humidity": humidity,
        "precip": precip,
        "pressure": pressure,
        "vis": vis,
        "cloud": cloud,
        "dew": dew,
      };
}

class Refer {
  Refer({
    required this.sources,
    required this.license,
  });

  List<String> sources;
  List<String> license;

  factory Refer.fromJson(Map<String, dynamic> json) => Refer(
        sources: List<String>.from(json["sources"].map((x) => x)),
        license: List<String>.from(json["license"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sources": List<dynamic>.from(sources.map((x) => x)),
        "license": List<dynamic>.from(license.map((x) => x)),
      };
}
