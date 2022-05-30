import 'package:assignment_manabie/features/to_do/data/datasources/local_todo_source.dart';
import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';
import 'package:assignment_manabie/core/error/failure.dart';
import 'package:assignment_manabie/features/to_do/domain/repositories/todo_repository.dart';
import 'package:dartz/dartz.dart';

class TodoRepositoryImpl implements TodoRepository {
  final LocalTodoSource localData;

  const TodoRepositoryImpl({required this.localData});

  @override
  Either<Failure, bool> createTodo(TodoModel todo) {
    List<TodoModel> _todos = localData.getTodos();
    _todos.insert(0, todo);
    localData.saveTodo(_todos);
    return Right(true);
  }

  @override
  Either<Failure, bool> deleteTodo(TodoModel todo) {
    List<TodoModel> _todos = localData.getTodos();
    int _indexOfTodo = _todos.indexWhere((todoElement) => todoElement.id == todo.id);
    if (_indexOfTodo != -1) {
      _todos.removeAt(_indexOfTodo);
      localData.saveTodo(_todos);
      return Right(true);
    }
    return Left(CannotFoundItem());
  }

  @override
  Either<Failure, List<TodoModel>> getTodos() {
    return Right(localData.getTodos());
  }

  @override
  Either<Failure, bool> updateTodo(TodoModel todo) {
    List<TodoModel> _todos = localData.getTodos();
    int _indexOfTodo = _todos.indexWhere((todoElement) => todoElement.id == todo.id);
    if (_indexOfTodo != -1) {
      _todos[_indexOfTodo] = todo;
      localData.saveTodo(_todos);
      return Right(true);
    }
    return Left(CannotFoundItem());
  }
}
