import 'package:canchas_test_app/core/core.dart';
import 'package:canchas_test_app/modules/home/home.dart';
import 'package:hive/hive.dart';

class SchedulingRepository {
  late Box box;

  SchedulingRepository() {
    getBox();
  }

  Future getBox() async {
    box = await Hive.openBox("schedulings");
    return Future.value(true);
  }

  List<SchedulingDataModel> getSchedulings() {
    final list = box.keys.where((element) {
      final data = box.get(element);

      final item = SchedulingModel.fromJson(data);
      return item.date.difference(DateTime.now()).inDays >= 0;
    });

    return list
        .map(
            (e) => SchedulingDataModel(e, SchedulingModel.fromJson(box.get(e))))
        .toList();
  }

  int countSchedulingByDateAndCourt(courtId, date) {
    final list = box.values.where((element) {
      final item = SchedulingModel.fromJson(element);
      return item.court.id == courtId && item.date.difference(date).inDays == 0;
    });
    return list.length;
  }

  Future<int> addScheduling(SchedulingModel scheduling) {
    return box.add(scheduling.toJson());
  }

  Future removeScheduling(int key) {
    return box.delete(key);
  }

  bool isCourtAvailable(courtId, DateTime date) {
    final count = countSchedulingByDateAndCourt(courtId, date);
    return count >= 3 ? false : true;
  }
}
