import 'dart:convert';

GeoModel geoModelFromJson(String str) => GeoModel.fromJson(json.decode(str));

String geoModelToJson(GeoModel data) => json.encode(data.toJson());

class GeoModel {
  GeoModel({
    required this.code,
    required this.location,
    required this.refer,
  });

  String code;
  List<Glocation> location;
  Refer refer;

  factory GeoModel.fromJson(Map<String, dynamic> json) => GeoModel(
        code: json["code"],
        location: List<Glocation>.from(
            json["location"].map((x) => Glocation.fromJson(x))),
        refer: Refer.fromJson(json["refer"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "location": List<dynamic>.from(location.map((x) => x.toJson())),
        "refer": refer.toJson(),
      };
}

class Glocation {
  Glocation({
    required this.name,
    required this.id,
    required this.lat,
    required this.lon,
    required this.adm2,
    required this.adm1,
    required this.country,
    required this.tz,
    required this.utcOffset,
    required this.isDst,
    required this.type,
    required this.rank,
    required this.fxLink,
  });

  String name;
  String id;
  String lat;
  String lon;
  String adm2;
  String adm1;
  String country;
  String tz;
  String utcOffset;
  String isDst;
  String type;
  String rank;
  String fxLink;

  factory Glocation.fromJson(Map<String, dynamic> json) => Glocation(
        name: json["name"],
        id: json["id"],
        lat: json["lat"],
        lon: json["lon"],
        adm2: json["adm2"],
        adm1: json["adm1"],
        country: json["country"],
        tz: json["tz"],
        utcOffset: json["utcOffset"],
        isDst: json["isDst"],
        type: json["type"],
        rank: json["rank"],
        fxLink: json["fxLink"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "lat": lat,
        "lon": lon,
        "adm2": adm2,
        "adm1": adm1,
        "country": country,
        "tz": tz,
        "utcOffset": utcOffset,
        "isDst": isDst,
        "type": type,
        "rank": rank,
        "fxLink": fxLink,
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
