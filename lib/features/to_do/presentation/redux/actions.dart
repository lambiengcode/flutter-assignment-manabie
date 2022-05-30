import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';

class GetTodosAction {
  final List<TodoModel> todos;
  GetTodosAction({required this.todos});
}

class CreateTodoAction {
  final TodoModel todoModel;

  CreateTodoAction({required this.todoModel});
}

class UpdateTodoAction {
  final TodoModel todoModel;

  UpdateTodoAction({required this.todoModel});
}

class DeleteTodoAction {
  final TodoModel todoModel;

  DeleteTodoAction({required this.todoModel});
}
