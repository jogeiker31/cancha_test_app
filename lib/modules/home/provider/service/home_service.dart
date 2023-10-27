import 'package:canchas_test_app/core/models/api_response.dart';
import 'package:canchas_test_app/core/repository/api_repository.dart';
import 'package:canchas_test_app/modules/add_scheduling/add_scheduling.dart';
import 'package:canchas_test_app/modules/home/home.dart';
import 'package:flutter/material.dart';

class HomeService extends ChangeNotifier {
  List<SchedulingDataModel> schedulingData = [];

  HomeService(this.schedulingRepository, this.apiRepository) {
    schedulingRepository.getBox().then((value) {
      getSchedulingData();
    });
  }

  final SchedulingRepository schedulingRepository;
  final ApiRepository apiRepository;

  getSchedulingData() {
    schedulingData = schedulingRepository.getSchedulings();
    schedulingData.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    notifyListeners();
  }

  Future<ApiResponse> getWeatherByDate(DateTime date) {
    return apiRepository.dateTimeWeatherData(date);
  }

  removeScheduling(int key) {
    schedulingRepository.removeScheduling(key).then((value) {
      schedulingData =
          schedulingData.where((element) => element.id != key).toList();

      notifyListeners();
    });
  }
}
