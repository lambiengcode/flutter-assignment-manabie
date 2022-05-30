import 'package:assignment_manabie/core/routes/app_pages.dart';
import 'package:assignment_manabie/core/utils/sizer_custom/sizer.dart';
import 'package:assignment_manabie/features/to_do/data/models/app_state.dart';
import 'package:assignment_manabie/features/to_do/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class App extends StatefulWidget {
  final Store<AppState> store;
  const App({Key? key, required this.store}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return StoreProvider(
          store: widget.store,
          child: MaterialApp(
            navigatorKey: AppNavigator.navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Manabie',
            onGenerateRoute: (settings) {
              return AppNavigator().getRoute(settings);
            },
            home: HomeScreen(),
          ),
        );
      },
    );
  }
}
