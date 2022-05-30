import 'package:assignment_manabie/core/error/failure.dart';
import 'package:assignment_manabie/core/usecases/usecase.dart';
import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';
import 'package:assignment_manabie/features/to_do/domain/repositories/todo_repository.dart';
import 'package:assignment_manabie/features/to_do/domain/usecases/get_todos.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateMocks([TodoRepository])
TodoModel todoModel = TodoModel(
  id: "1",
  title: 'TC-Get',
  subTitle: 'TC',
  createdAt: DateTime.now(),
);

class MockTodoRepository extends Mock implements TodoRepository {
  @override
  Either<Failure, List<TodoModel>> getTodos() {
    return (super.noSuchMethod(Invocation.method(#getTodos, [])) ??
        Right([todoModel]));
  }
}

void main() {
  late GetTodos usecase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = GetTodos(repository: mockTodoRepository);
  });

  test(
    'should get a todo model in list from repository',
    () async {
      when(mockTodoRepository.getTodos()).thenAnswer((_) => Right([todoModel]));
      // act
      final result = usecase(NoParams());
      // assert
      expect(result.isRight(), Right<Failure, List<TodoModel>>([todoModel]).isRight());
      verify(mockTodoRepository.getTodos());
      verifyNoMoreInteractions(mockTodoRepository);
    },
  );
}
