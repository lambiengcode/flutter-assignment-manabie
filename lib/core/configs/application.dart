import 'package:assignment_manabie/injection_container.dart' as di;
import 'package:flutter/material.dart';

class Application {
  /// [Production - Dev]
  Future<void> initialAppLication() async {
    try {
      await di.init();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  ///Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
