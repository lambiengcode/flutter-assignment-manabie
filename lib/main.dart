import 'package:assignment_manabie/app.dart';
import 'package:assignment_manabie/core/configs/application.dart';
import 'package:assignment_manabie/features/to_do/data/models/app_state.dart';
import 'package:assignment_manabie/features/to_do/presentation/redux/reducers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));

  await Application().initialAppLication();
  
  runApp(App(
    store: Store<AppState>(
      appReducer,
      initialState: AppState(todos: []),
    ),
  ));
}
