import 'package:assignment_manabie/core/error/failure.dart';
import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class Params extends Equatable {
  final TodoModel todo;

  const Params({required this.todo});

  @override
  List<Object> get props => [todo];
}
