import 'package:assignment_manabie/core/common/app_colors.dart';
import 'package:assignment_manabie/core/common/widgets/app_bar_common.dart';
import 'package:assignment_manabie/core/error/failure.dart';
import 'package:assignment_manabie/core/routes/app_pages.dart';
import 'package:assignment_manabie/core/routes/app_routes.dart';
import 'package:assignment_manabie/core/styles/style.dart';
import 'package:assignment_manabie/core/usecases/usecase.dart';
import 'package:assignment_manabie/features/to_do/data/models/app_state.dart';
import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';
import 'package:assignment_manabie/features/to_do/domain/usecases/delete_todo.dart';
import 'package:assignment_manabie/features/to_do/domain/usecases/get_todos.dart';
import 'package:assignment_manabie/features/to_do/domain/usecases/update_todo.dart';
import 'package:assignment_manabie/features/to_do/presentation/redux/actions.dart';
import 'package:assignment_manabie/features/to_do/presentation/redux/selectors.dart';
import 'package:assignment_manabie/features/to_do/presentation/widgets/todo_list.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:assignment_manabie/core/utils/sizer_custom/sizer.dart';
import 'package:redux/redux.dart';

import '../../../../injection_container.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex;
  const HomeScreen({Key? key, this.initialIndex = 0}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _titles = ['Todos', 'Incompleted', 'Completed'];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCommon(
        title: _titles[_currentPage],
        actions: [
          IconButton(
            onPressed: () {
              AppNavigator.push(Routes.createTodo);
            },
            icon: Icon(
              PhosphorIcons.listPlus,
              color: colorPrimary,
              size: 18.sp,
            ),
          ),
        ],
      ),
      backgroundColor: mC,
      body: StoreConnector<AppState, _ViewModel>(
        onInit: (store) {
          dz.Either<Failure, List<TodoModel>> _todosLocal = sl<GetTodos>().call(NoParams());
          store.dispatch(GetTodosAction(todos: _todosLocal.fold(
            (l) => [],
            (r) => r,
          )));
        },
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          List<TodoModel> todos = [];
          if (_currentPage == 0) {
            todos = vm.todos;
          } else if (_currentPage == 1) {
            todos = vm.todosIncomplete;
          } else {
            todos = vm.todosComplete;
          }
          return TodoList(
            todos: todos,
            onCheckboxChanged: vm.onCheckboxChanged,
            onRemove: vm.onRemove,
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: .0,
        child: Container(
          height: 48.sp,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Theme.of(context).dividerColor,
                width: .2,
              ),
            ),
          ),
          child: Row(
            children: [
              _buildItemBottomBar(
                PhosphorIcons.listDashes,
                PhosphorIcons.listDashesFill,
                0,
                'Todos',
              ),
              _buildItemBottomBar(
                PhosphorIcons.listNumbers,
                PhosphorIcons.listNumbersFill,
                1,
                'Incompleted',
              ),
              _buildItemBottomBar(
                PhosphorIcons.listChecks,
                PhosphorIcons.listChecksFill,
                2,
                'Completed',
              ),
            ],
          ),
        ),
      ),
      // body: _screens[currentPage],
    );
  }

  Widget _buildItemBottomBar(inActiveIcon, activeIcon, index, title) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentPage = index;
          });
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.transparent,
                child: Icon(
                  index == _currentPage ? activeIcon : inActiveIcon,
                  size: 18.5.sp,
                  color: index == _currentPage
                      ? colorPrimary
                      : Theme.of(context).textTheme.bodyText2!.color,
                ),
              ),
              SizedBox(height: 2.5.sp),
              Text(
                title,
                style: TextStyle(
                  color: _currentPage == index
                      ? colorPrimary
                      : Theme.of(context).textTheme.bodyText2?.color,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ViewModel {
  final List<TodoModel> todos;
  final List<TodoModel> todosIncomplete;
  final List<TodoModel> todosComplete;
  final Function(TodoModel, bool) onCheckboxChanged;
  final Function(TodoModel) onRemove;

  _ViewModel({
    required this.todos,
    required this.onCheckboxChanged,
    required this.onRemove,
    required this.todosIncomplete,
    required this.todosComplete,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      todos: todosSelector(store.state.todos),
      todosIncomplete: todosIncompleteSelector(store.state.todos),
      todosComplete: todosCompleteSelector(store.state.todos),
      onCheckboxChanged: (todo, complete) {
        TodoModel _todo = todo.copyWith(isDone: complete);
        store.dispatch(UpdateTodoAction(
          todoModel: _todo,
        ));
        sl<UpdateTodo>().call(Params(todo: _todo));
      },
      onRemove: (todo) {
        store.dispatch(DeleteTodoAction(todoModel: todo));
        sl<DeleteTodo>().call(Params(todo: todo));
      },
    );
  }
}
