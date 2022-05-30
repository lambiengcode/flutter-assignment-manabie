import 'package:assignment_manabie/core/constant/storage_key.dart';
import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';
import 'package:hive/hive.dart';

abstract class LocalTodoSource {
  List<TodoModel> getTodos();
  void saveTodo(List<TodoModel> todos);
  void clearTodo();
}

class LocalTodoSourceImpl implements LocalTodoSource {
  final Box box;
  const LocalTodoSourceImpl({required this.box});

  @override
  List<TodoModel> getTodos() {
    List todosRaw = box.get(StorageKey.todos) ?? [];
    return todosRaw.map((todo) => TodoModel.fromJson(todo)).toList();
  }

  @override
  void saveTodo(List<TodoModel> todos) {
    box.put(StorageKey.todos, todos.map((todo) => todo.toJson()).toList());
  }

  @override
  void clearTodo() {
    box.clear();
  }
}
