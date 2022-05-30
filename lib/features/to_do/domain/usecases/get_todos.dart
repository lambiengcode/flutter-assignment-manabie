import 'package:assignment_manabie/core/error/failure.dart';
import 'package:assignment_manabie/core/usecases/usecase.dart';
import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';
import 'package:assignment_manabie/features/to_do/domain/repositories/todo_repository.dart';
import 'package:dartz/dartz.dart';

class GetTodos implements UseCase<List<TodoModel>, NoParams> {
  final TodoRepository repository;

  const GetTodos({required this.repository});

  @override
  Either<Failure, List<TodoModel>> call(NoParams params) {
    return repository.getTodos();
  }
}
