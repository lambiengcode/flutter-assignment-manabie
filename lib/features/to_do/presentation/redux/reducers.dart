import 'package:assignment_manabie/features/to_do/data/models/app_state.dart';
import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';
import 'package:assignment_manabie/features/to_do/presentation/redux/actions.dart';
import 'package:redux/redux.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    todos: todosReducer(state.todos, action),
  );
}

final todosReducer = combineReducers<List<TodoModel>>([
  TypedReducer<List<TodoModel>, CreateTodoAction>(_addTodo),
  TypedReducer<List<TodoModel>, DeleteTodoAction>(_deleteTodo),
  TypedReducer<List<TodoModel>, UpdateTodoAction>(_updateTodo),
  TypedReducer<List<TodoModel>, GetTodosAction>(_getTodos),
]);

List<TodoModel> _addTodo(List<TodoModel> todos, CreateTodoAction action) {
  return List.from(todos)..insert(0, action.todoModel);
}

List<TodoModel> _updateTodo(List<TodoModel> todos, UpdateTodoAction action) {
  return todos.map((todo) {
    return todo.id == action.todoModel.id ? action.todoModel : todo;
  }).toList();
}

List<TodoModel> _deleteTodo(List<TodoModel> todos, DeleteTodoAction action) {
  return todos.where((todo) => todo.id != action.todoModel.id).toList();
}

List<TodoModel> _getTodos(List<TodoModel> todos, GetTodosAction action) {
  return action.todos;
}
