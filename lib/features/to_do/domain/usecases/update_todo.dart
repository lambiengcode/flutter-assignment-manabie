import 'package:assignment_manabie/core/error/failure.dart';
import 'package:assignment_manabie/core/usecases/usecase.dart';
import 'package:assignment_manabie/features/to_do/domain/repositories/todo_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateTodo implements UseCase<bool, Params> {
  final TodoRepository repository;

  const UpdateTodo({required this.repository});

  @override
  Either<Failure, bool> call(Params params) {
    return repository.updateTodo(params.todo);
  }
}
