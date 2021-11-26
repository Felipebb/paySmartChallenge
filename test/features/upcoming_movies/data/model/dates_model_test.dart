import 'package:api_teste/features/upcoming_movies/data/models/dates_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Map<String, String> response;
  late DatesModel datesModel;

  setUp(() async {
    response = {
      "maximum": "2021-12-22",
      "minimum": "2021-12-01",
    };
  });

  group('DatesModel Json Parser', () {
    test('[ DatesModel ] should be parsed', () {
      datesModel = DatesModel.fromJson(response);

      expect(datesModel, equals(isNotNull));
    });

    test('maximum should be [2021-12-22] ', () {
      expect(datesModel.maximum, '2021-12-22');
    });

    test('minimum should be [2021-12-01] ', () {
      expect(datesModel.minimum, '2021-12-01');
    });
  });
}
