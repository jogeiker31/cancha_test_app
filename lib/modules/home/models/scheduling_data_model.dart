import 'package:canchas_test_app/core/core.dart';

class SchedulingDataModel {
  final int id;
  final SchedulingModel schedulingModel;

  SchedulingDataModel(this.id, this.schedulingModel);

  get image {
    return schedulingModel.court.image;
  }

  get courtName {
    return schedulingModel.court.name;
  }

  get name {
    return schedulingModel.name;
  }

  DateTime get date {
    return schedulingModel.date;
  }
}
