import 'package:assignment_manabie/core/routes/app_pages.dart';
import 'package:flutter/material.dart';

showDialogLoading() {
  showDialog(
    context: AppNavigator.context!,
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    },
    barrierColor: Color(0x80000000),
    barrierDismissible: false,
  );
}
