import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';

List<TodoModel> todosSelector(List<TodoModel> todos) => todos;

List<TodoModel> todosIncompleteSelector(List<TodoModel> todos) => todos.where((todo) => !todo.isDone).toList();

List<TodoModel> todosCompleteSelector(List<TodoModel> todos) => todos.where((todo) => todo.isDone).toList();

