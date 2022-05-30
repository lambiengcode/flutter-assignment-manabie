import 'dart:convert';

import 'package:assignment_manabie/core/error/failure.dart';
import 'package:assignment_manabie/features/to_do/data/datasources/local_todo_source.dart';
import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';
import 'package:assignment_manabie/features/to_do/data/repositories/todo_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

class MockLocalDataSource extends Mock implements LocalTodoSource {
  @override
  List<TodoModel> getTodos() {
    return super.noSuchMethod(Invocation.method(#getTodos, [])) ?? [];
  }
}

void main() {
  late TodoRepositoryImpl repository;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = TodoRepositoryImpl(localData: mockLocalDataSource);
  });

  group('get todos', () {
    final List<dynamic> arrayRaw = jsonDecode(fixture('todo_json.json'));
    final List<TodoModel> todos = arrayRaw.map((todo) => TodoModel.fromMap(todo)).toList();

    test(
      'should return list todo model',
      () async {
        // arrange
        when(mockLocalDataSource.getTodos()).thenAnswer((_) => todos);
        // act
        await repository.getTodos();
        // assert
        verifyNever(mockLocalDataSource.saveTodo(todos));
      },
    );
  });

  group('create todo', () {
    final List<dynamic> arrayRaw = jsonDecode(fixture('todo_json.json'));
    final List<TodoModel> todos = arrayRaw.map((todo) => TodoModel.fromMap(todo)).toList();
    final dynamic raw = jsonDecode(fixture('todo_model.json'));
    final TodoModel todo = TodoModel.fromMap(raw);

    test(
      'should return list todo model',
      () async {
        // arrange
        when(mockLocalDataSource.getTodos()).thenAnswer((_) => todos);
        // act
        await repository.createTodo(todo);
        // assert
        verify(mockLocalDataSource.getTodos());
        verify(mockLocalDataSource.saveTodo(todos));
      },
    );
  });

  group('update todo', () {
    final List<dynamic> arrayRaw = jsonDecode(fixture('todo_json.json'));
    final List<TodoModel> todos = arrayRaw.map((todo) => TodoModel.fromMap(todo)).toList();
    final dynamic raw = jsonDecode(fixture('todo_model.json'));
    final TodoModel todo = TodoModel.fromMap(raw);

    test(
      'should update success - found item in list',
      () async {
        // arrange
        when(mockLocalDataSource.getTodos()).thenAnswer((_) => todos);
        // act
        final result = await repository.updateTodo(todo);
        // assert
        expect(result, Right<Failure, bool>(true));
        verify(mockLocalDataSource.getTodos());
        verify(mockLocalDataSource.saveTodo(todos));
      },
    );

    test(
      'should update failure - not found item in list',
      () async {
        // arrange
        when(mockLocalDataSource.getTodos()).thenAnswer((_) => todos);
        // act
        final result = await repository.updateTodo(todo.copyWith(id: 'not found'));
        // assert
        expect(result, Left(CannotFoundItem()));
        verify(mockLocalDataSource.getTodos());
        verifyNever(mockLocalDataSource.saveTodo(todos));
      },
    );
  });

  group('delete todo', () {
    final List<dynamic> arrayRaw = jsonDecode(fixture('todo_json.json'));
    final List<TodoModel> todos = arrayRaw.map((todo) => TodoModel.fromMap(todo)).toList();
    final dynamic raw = jsonDecode(fixture('todo_model.json'));
    final TodoModel todo = TodoModel.fromMap(raw);

    test(
      'should delete success - found item in list',
      () async {
        // arrange
        when(mockLocalDataSource.getTodos()).thenAnswer((_) => todos);
        // act
        final result = await repository.deleteTodo(todo);
        // assert
        expect(result, Right<Failure, bool>(true));
        verify(mockLocalDataSource.getTodos());
        verify(mockLocalDataSource.saveTodo(todos));
      },
    );

    test(
      'should update failure - not found item in list',
      () async {
        // arrange
        when(mockLocalDataSource.getTodos()).thenAnswer((_) => todos);
        // act
        final result = await repository.deleteTodo(todo.copyWith(id: 'not found'));
        // assert
        expect(result, Left(CannotFoundItem()));
        verify(mockLocalDataSource.getTodos());
        verifyNever(mockLocalDataSource.saveTodo(todos));
      },
    );
  });
}
