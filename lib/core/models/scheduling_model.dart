import 'dart:convert';

import 'package:canchas_test_app/core/core.dart';

class SchedulingModel {
    DateTime date;
    Court court;
    String name;

    SchedulingModel({
        required this.date,
        required this.court,
        required this.name,
    });

    SchedulingModel copyWith({
        DateTime? date,
        Court? court,
        String? name,
    }) => 
        SchedulingModel(
            date: date ?? this.date,
            court: court ?? this.court,
            name: name ?? this.name,
        );

    factory SchedulingModel.fromRawJson(String str) => SchedulingModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SchedulingModel.fromJson(Map<dynamic, dynamic> json) => SchedulingModel(
        date: DateTime.parse(json["date"]),
        court: Court.fromJson(json["court"]),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "court": court.toJson(),
        "name": name,
    };
}


