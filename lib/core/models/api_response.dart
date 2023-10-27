import 'dart:convert';

class ApiResponse {
  bool success;
  dynamic error;
  List<Response> response;

  Period? get firstPeriod {
    if (response.firstOrNull == null) return null;
    return response.first.periods.firstOrNull;
  }

  String get iconSky {
    switch (firstPeriod?.cloudsCoded) {
      case "FW":
        return "assets/vectors/sunny.svg";

      case "CL":
        return "assets/vectors/sunny.svg";
      case "SC":
        return "assets/vectors/mostly_cloudy.svg";
      case "BK":
        return "assets/vectors/mostly_cloudy.svg";
      case "OV":
        return "assets/vectors/cloudy.svg";

      default:
        return "assets/vectors/sunny.svg";
    }
  }

  ApiResponse({
    required this.success,
    required this.error,
    required this.response,
  });

  ApiResponse copyWith({
    bool? success,
    dynamic error,
    List<Response>? response,
  }) =>
      ApiResponse(
        success: success ?? this.success,
        error: error ?? this.error,
        response: response ?? this.response,
      );

  factory ApiResponse.fromRawJson(String str) =>
      ApiResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        success: json["success"],
        error: json["error"],
        response: List<Response>.from(
            json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class Response {
  Loc loc;
  List<Period> periods;

  Response({
    required this.loc,
    required this.periods,
  });

  Response copyWith({
    Loc? loc,
    List<Period>? periods,
  }) =>
      Response(
        loc: loc ?? this.loc,
        periods: periods ?? this.periods,
      );

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        loc: Loc.fromJson(json["loc"]),
        periods:
            List<Period>.from(json["periods"].map((x) => Period.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "loc": loc.toJson(),
        "periods": List<dynamic>.from(periods.map((x) => x.toJson())),
      };
}

class Loc {
  double long;
  double lat;

  Loc({
    required this.long,
    required this.lat,
  });

  Loc copyWith({
    double? long,
    double? lat,
  }) =>
      Loc(
        long: long ?? this.long,
        lat: lat ?? this.lat,
      );

  factory Loc.fromRawJson(String str) => Loc.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Loc.fromJson(Map<String, dynamic> json) => Loc(
        long: json["long"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "long": long,
        "lat": lat,
      };
}

class Period {
  DateTime dateTimeIso;
  int avgTempC;
  int pop;
  int sky;
  String cloudsCoded;
  int windSpeedKph;

  Period({
    required this.dateTimeIso,
    required this.avgTempC,
    required this.pop,
    required this.sky,
    required this.cloudsCoded,
    required this.windSpeedKph,
  });

  Period copyWith({
    DateTime? dateTimeIso,
    int? avgTempC,
    int? pop,
    int? sky,
    String? cloudsCoded,
    int? windSpeedKph,
  }) =>
      Period(
        dateTimeIso: dateTimeIso ?? this.dateTimeIso,
        avgTempC: avgTempC ?? this.avgTempC,
        pop: pop ?? this.pop,
        sky: sky ?? this.sky,
        cloudsCoded: cloudsCoded ?? this.cloudsCoded,
        windSpeedKph: windSpeedKph ?? this.windSpeedKph,
      );

  factory Period.fromRawJson(String str) => Period.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        dateTimeIso: DateTime.parse(json["dateTimeISO"]),
        avgTempC: json["avgTempC"],
        pop: json["pop"],
        sky: json["sky"],
        cloudsCoded: json["cloudsCoded"],
        windSpeedKph: json["windSpeedKPH"],
      );

  Map<String, dynamic> toJson() => {
        "dateTimeISO": dateTimeIso.toIso8601String(),
        "avgTempC": avgTempC,
        "pop": pop,
        "sky": sky,
        "cloudsCoded": cloudsCoded,
        "windSpeedKPH": windSpeedKph,
      };
}
