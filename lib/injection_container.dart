import 'package:assignment_manabie/core/configs/base_local_data.dart';
import 'package:assignment_manabie/core/constant/storage_key.dart';
import 'package:assignment_manabie/features/to_do/data/datasources/local_todo_source.dart';
import 'package:assignment_manabie/features/to_do/data/models/app_state.dart';
import 'package:assignment_manabie/features/to_do/data/repositories/todo_repository_impl.dart';
import 'package:assignment_manabie/features/to_do/domain/repositories/todo_repository.dart';
import 'package:assignment_manabie/features/to_do/domain/usecases/create_todo.dart';
import 'package:assignment_manabie/features/to_do/domain/usecases/delete_todo.dart';
import 'package:assignment_manabie/features/to_do/domain/usecases/get_todos.dart';
import 'package:assignment_manabie/features/to_do/domain/usecases/update_todo.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Todo
  // Redux
  sl.registerFactory(
    () => AppState(todos: []),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTodos(repository: sl()));
  sl.registerLazySingleton(() => CreateTodo(repository: sl()));
  sl.registerLazySingleton(() => UpdateTodo(repository: sl()));
  sl.registerLazySingleton(() => DeleteTodo(repository: sl()));

  // Repository
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      localData: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<LocalTodoSource>(
    () => LocalTodoSourceImpl(box: sl()),
  );

  //! External
  await BaseLocalData.initialBox();
  Box box = Hive.box(StorageKey.todos);
  sl.registerLazySingleton(() => box);
}
