import 'package:assignment_manabie/core/error/failure.dart';
import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';
import 'package:dartz/dartz.dart';


abstract class TodoRepository {
  Either<Failure, List<TodoModel>> getTodos();
  Either<Failure, bool> createTodo(TodoModel todo);
  Either<Failure, bool> updateTodo(TodoModel todo);
  Either<Failure, bool> deleteTodo(TodoModel todo);
}
