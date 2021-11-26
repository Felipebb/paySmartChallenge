import '../../domain/entities/dates.dart';

class DatesModel extends Dates {
  DatesModel({String? maximum, String? minimum})
      : super(maximum: maximum, minimum: minimum);

  DatesModel.fromJson(Map<String, dynamic> json) {
    maximum = json['maximum'];
    minimum = json['minimum'];
  }
}
