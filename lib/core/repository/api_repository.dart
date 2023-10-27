import 'dart:convert';

import 'package:canchas_test_app/core/models/api_response.dart';
import 'package:intl/intl.dart';
import "package:http/http.dart" as http;

String idClient = "xi9pUJ5OcrUndGAm1ldkP";
String secretClient = "C3WT9gWS6srkcsabPSSMzZAEM4Rl7ljAQTaYwgom";

class ApiRepository {
  Future<ApiResponse> dateTimeWeatherData(DateTime date) async {
    final url = Uri.https("api.aerisapi.com", "/forecasts/miami,us", {
      "client_id": idClient,
      "client_secret": secretClient,
      "limit": "1",
      "filter": "day",
      "format": "json",
      "fields":
          "loc,periods.dateTimeISO,periods.avgTempC,periods.pop,periods.sky,periods.cloudsCoded,periods.windSpeedKPH",
      "from": DateFormat("yyyy/MM/dd").format(date)
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final ApiResponse apiResponse =
          ApiResponse.fromJson(json.decode(response.body));
      return Future.value(apiResponse);
    } else {
      return Future.error(false);
    }
  }
}
