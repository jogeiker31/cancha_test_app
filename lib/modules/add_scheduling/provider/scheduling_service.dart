import 'package:canchas_test_app/core/core.dart';
import 'package:canchas_test_app/core/models/api_response.dart';
import 'package:canchas_test_app/core/repository/api_repository.dart';
import 'package:canchas_test_app/modules/add_scheduling/add_scheduling.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SchedulingService extends ChangeNotifier {
  SchedulingService(this.addSchedulingRepository, this.apiRepository);

  final SchedulingRepository addSchedulingRepository;
  final ApiRepository apiRepository;

  final TextEditingController textController = TextEditingController();
  ApiResponse? _weatherData;

  Court? _courtSelected;

  DateTime? _dateSelected;

  String _name = "";

  String get name {
    return _name;
  }

  ApiResponse? get weatherData {
    return _weatherData;
  }

  set weatherData(ApiResponse? data) {
    _weatherData = data;
    notifyListeners();
  }

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  Court? get courtSelected {
    return _courtSelected;
  }

  DateTime? get dateSelected {
    return _dateSelected;
  }

  String get dateInText {
    return dateSelected != null
        ? DateFormat("dd/MM/yyyy").format(dateSelected!)
        : "";
  }

  bool get canCreate {
    return dateSelected != null &&
        courtSelected != null &&
        available == true &&
        name != "";
  }

  get dayweek {
    return DayweekText.name(dateSelected?.weekday ?? 0);
  }

  set courtSelected(Court? court) {
    _courtSelected = court;
    if (dateSelected != null) {
      available =
          addSchedulingRepository.isCourtAvailable(court?.id, dateSelected!);
    }

    notifyListeners();
  }

  set dateSelected(DateTime? date) {
    _dateSelected = date;
    textController.text =
        date != null ? DateFormat("dd/MM/yyyy").format(date) : "";

    if (courtSelected != null && date != null) {
      available =
          addSchedulingRepository.isCourtAvailable(courtSelected!.id, date);
    }
    getWeatherByDate(date!);
    notifyListeners();
  }

  Future<bool> createScheduling() async {
    final data =
        SchedulingModel(date: dateSelected!, court: courtSelected!, name: name);

    await addSchedulingRepository.addScheduling(data);

    return Future.value(true);
  }

  bool available = true;

  getWeatherByDate(DateTime date) {
    weatherData = null;
    apiRepository.dateTimeWeatherData(date).then((value) {
      weatherData = value;
      notifyListeners();
    }).catchError((e) {
      weatherData = null;
    });
  }
}
