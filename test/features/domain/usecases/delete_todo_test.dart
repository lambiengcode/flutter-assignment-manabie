import 'package:assignment_manabie/core/error/failure.dart';
import 'package:assignment_manabie/core/usecases/usecase.dart';
import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';
import 'package:assignment_manabie/features/to_do/domain/repositories/todo_repository.dart';
import 'package:assignment_manabie/features/to_do/domain/usecases/delete_todo.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockTodoRepository extends Mock implements TodoRepository {
  @override
  Either<Failure, bool> deleteTodo(TodoModel todo) {
    return super.noSuchMethod(Invocation.method(#deleteTodo, [])) ?? Right<Failure, bool>(true);
  }
}

void main() {
  late DeleteTodo usecase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = DeleteTodo(repository: mockTodoRepository);
  });

  final TodoModel todoModel = TodoModel(
    id: "1",
    title: 'TC-Get',
    subTitle: 'TC',
    createdAt: DateTime.fromMillisecondsSinceEpoch(1653884620962),
  );

  test(
    'should delete a todo model',
    () async {
      when(mockTodoRepository.deleteTodo(todoModel)).thenAnswer((_) => Right<Failure, bool>(true));
      // act
      final result = usecase(Params(todo: todoModel));
      // assert
      expect(result, Right<Failure, bool>(true));
      verify(mockTodoRepository.deleteTodo(todoModel));
      verifyNoMoreInteractions(mockTodoRepository);
    },
  );
}
