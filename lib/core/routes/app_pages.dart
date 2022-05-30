import 'package:assignment_manabie/app.dart';
import 'package:assignment_manabie/core/routes/app_navigator_observer.dart';
import 'package:assignment_manabie/core/routes/app_routes.dart';
import 'package:assignment_manabie/core/routes/scaffold_wrapper.dart';
import 'package:assignment_manabie/core/routes/transition_route.dart';
import 'package:assignment_manabie/features/to_do/data/models/app_state.dart';
import 'package:assignment_manabie/features/to_do/presentation/redux/reducers.dart';
import 'package:assignment_manabie/features/to_do/presentation/screens/create_todo_screen.dart';
import 'package:assignment_manabie/features/to_do/presentation/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class AppNavigator extends RouteObserver<PageRoute<dynamic>> {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  Route<dynamic> getRoute(RouteSettings settings) {
    Map<String, dynamic>? arguments = _getArguments(settings);
    switch (settings.name) {
      case Routes.root:
        return _buildRoute(
          settings,
          App(
            store: Store<AppState>(
              appReducer,
              initialState: AppState(todos: []),
            ),
          ),
        );

      case Routes.createTodo:
        return _buildRoute(
          settings,
          CreateTodoScreen(
            todoModel: arguments?['todoModel'],
          ),
        );

      default:
        return _buildRoute(settings, const HomeScreen());
    }
  }

  _buildRoute(
    RouteSettings routeSettings,
    Widget builder,
  ) {
    return AppMaterialPageRoute(
      builder: (context) => ScaffoldWrapper(child: builder),
      settings: routeSettings,
    );
  }

  _getArguments(RouteSettings settings) {
    return settings.arguments;
  }

  static Future push<T>(
    String route, {
    Object? arguments,
  }) {
    return state.pushNamed(route, arguments: arguments);
  }

  static Future pushNamedAndRemoveUntil<T>(
    String route, {
    Object? arguments,
  }) {
    return state.pushNamedAndRemoveUntil(
      route,
      (route) => false,
      arguments: arguments,
    );
  }

  static Future replaceWith<T>(
    String route, {
    Map<String, dynamic>? arguments,
  }) {
    return state.pushReplacementNamed(route, arguments: arguments);
  }

  static void popUntil<T>(String route) {
    state.popUntil(ModalRoute.withName(route));
  }

  static void pop() {
    if (canPop) {
      state.pop();
    }
  }

  static bool get canPop => state.canPop();

  static String? currentRoute() => AppNavigatorObserver.currentRouteName;

  static BuildContext? get context => navigatorKey.currentContext;

  static NavigatorState get state => navigatorKey.currentState!;
}
