import 'package:assignment_manabie/core/constant/constant.dart';
import 'package:flutter/material.dart';

class AppMaterialPageRoute<T> extends MaterialPageRoute<T> {
  AppMaterialPageRoute({
    required WidgetBuilder builder,
    required RouteSettings settings,
  }) : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => const Duration(
        milliseconds: Constants.delay250Ms,
      );

  @override
  @protected
  bool get hasScopedWillPopCallback {
    return false;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    return theme.buildTransitions<T>(
      this,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
