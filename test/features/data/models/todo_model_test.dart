import 'dart:convert';

import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  final TodoModel todoModel = TodoModel(
    id: "1",
    title: 'TC-Get',
    subTitle: 'TC',
    createdAt: DateTime.fromMillisecondsSinceEpoch(1653884620962),
  );

  test(
    'should be a subclass of Todo entity',
    () async {
      // assert
      expect(todoModel, isA<TodoModel>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON',
      () async {
        // arrange
        final String jsonMap =
            fixture('todo_model.json');
        // act
        final result = TodoModel.fromJson(jsonMap);
        // assert
        expect(result, todoModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = todoModel.toJson();
        // assert
        final expectedMap = {
          "id": "1",
          "title": "TC-Get",
          "subTitle": "TC",
          "createdAt": 1653884620962,
          "isDone": false,
        };
        expect(result, jsonEncode(expectedMap));
      },
    );
  });
}
