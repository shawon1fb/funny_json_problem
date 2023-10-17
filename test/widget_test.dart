import 'package:funny_json_problem/dummy.json.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('_findAndConvertToModel', () {
    test('should return an empty list when given an empty list', () {
      final result = JsonParser.findAndConvertToModel([]);
      expect(result, equals(<AndroidVerison>[]));
    });

    test(
        'should return a list of AndroidVersion models when given a list of maps with id and title keys',
        () {
      final data = [
        {'id': 1, 'title': 'Android 1'},
        {'id': 2, 'title': 'Android 2'},
        {'id': 3, 'title': 'Android 3'},
      ];
      final result = JsonParser.findAndConvertToModel(data);
      expect(result.length, equals(3));
      expect(result[0].id, equals(1));
      expect(result[0].title, equals('Android 1'));
      expect(result[1].id, equals(2));
      expect(result[1].title, equals('Android 2'));
      expect(result[2].id, equals(3));
      expect(result[2].title, equals('Android 3'));
    });

    test(
        'should return a list of AndroidVersion models when given a nested map with id and title keys',
        () {
      final data = {
        '1': [
          {'id': 1, 'title': 'Android 1'},
          {'id': 2, 'title': 'Android 2'},
          {'id': 3, 'title': 'Android 3'},
        ],
        '0': [
          {'id': 4, 'title': 'iOS 1'},
          {'id': 5, 'title': 'iOS 2'},
        ],
      };
      final result = JsonParser.findAndConvertToModel(data);
      expect(result.length, equals(5));
      expect(result[0].id, equals(1));
      expect(result[0].title, equals('Android 1'));
      expect(result[1].id, equals(2));
      expect(result[1].title, equals('Android 2'));
      expect(result[2].id, equals(3));
      expect(result[2].title, equals('Android 3'));
      expect(result[3].id, equals(4));
      expect(result[3].title, equals('iOS 1'));
      expect(result[4].id, equals(5));
      expect(result[4].title, equals('iOS 2'));
    });

    test(
        'should return a list of AndroidVersion models when given a map with id and title keys and a nested list of maps with id and title keys',
        () {
      final data = {
        'id': 1,
        'title': 'Android 1',
        '0': [
          {'id': 2, 'title': 'Android 2'},
          {'id': 3, 'title': 'Android 3'},
        ],
      };
      final result = JsonParser.findAndConvertToModel(data);
      //print(result.map((e) => { "id": e.id, "title": e.title }).toString());
      expect(result.length, equals(3));
      expect(result[0].id, equals(1));
      expect(result[0].title, equals('Android 1'));

      expect(result[1].id, equals(2));
      expect(result[1].title, equals('Android 2'));
      expect(result[2].id, equals(3));
      expect(result[2].title, equals('Android 3'));
    });
  });
}
