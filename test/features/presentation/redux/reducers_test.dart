import 'package:assignment_manabie/features/to_do/data/models/app_state.dart';
import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';
import 'package:assignment_manabie/features/to_do/presentation/redux/actions.dart';
import 'package:assignment_manabie/features/to_do/presentation/redux/reducers.dart';
import 'package:assignment_manabie/features/to_do/presentation/redux/selectors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

void main() {
  final TodoModel todoModel = TodoModel(
    id: "1",
    title: 'TC-Get',
    subTitle: 'TC',
    createdAt: DateTime.fromMillisecondsSinceEpoch(1653884620962),
  );

  group('State Reducer', () {
    test('should add a todo to the list in response to an CreateTodoAction', () {
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(todos: []),
      );

      store.dispatch(CreateTodoAction(todoModel: todoModel));

      expect(todosSelector(store.state.todos), [todoModel]);
    });

    test('should remove from the list in response to a DeleteTodoAction', () {
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(todos: [todoModel]),
      );

      expect(todosSelector(store.state.todos), [todoModel]);

      store.dispatch(DeleteTodoAction(todoModel: todoModel));

      expect(todosSelector(store.state.todos), []);
    });

    test('should update a todo in response to an UpdateTodoAction', () {
      final updatedTodo = todoModel.copyWith(isDone: true);
      final store = Store<AppState>(
        appReducer,
        initialState: AppState(todos: [todoModel]),
      );

      store.dispatch(UpdateTodoAction(todoModel: updatedTodo));

      expect(todosSelector(store.state.todos), [updatedTodo]);
    });
  });
}
