import 'dart:convert';
import 'package:assignment_manabie/core/constant/storage_key.dart';
import 'package:assignment_manabie/features/to_do/data/datasources/local_todo_source.dart';
import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../fixtures/fixture_reader.dart';

class MockHiveBox extends Mock implements Box {}

void main() {
  late LocalTodoSourceImpl dataSource;
  late MockHiveBox mockHiveBox;

  setUp(() {
    mockHiveBox = MockHiveBox();
    dataSource = LocalTodoSourceImpl(
      box: mockHiveBox,
    );
  });

  group('get list todo', () {
    final List<dynamic> arrayRaw = jsonDecode(fixture('todo_json.json'));
    final List<TodoModel> todos = arrayRaw.map((todo) => TodoModel.fromMap(todo)).toList();

    test(
      'should return array todo model',
      () async {
        // arrange
        when(mockHiveBox.get(StorageKey.todos)).thenReturn(arrayRaw.map((todo) => jsonEncode(todo)).toList());
        // act
        final result = dataSource.getTodos();
        // assert
        verify(mockHiveBox.get(StorageKey.todos));
        expect(result, equals(todos));
      },
    );
  });
}
