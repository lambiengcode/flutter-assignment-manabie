import 'package:assignment_manabie/core/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:assignment_manabie/core/utils/sizer_custom/sizer.dart';
import 'package:flutter/services.dart';

AppBar appBarCommon({required String title, List<Widget>? actions, Widget? leading}) {
  return AppBar(
    automaticallyImplyLeading: false,
    leading: leading,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    centerTitle: leading != null,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
    title: Padding(
      padding: EdgeInsets.only(left: leading == null ? 2.5.sp : 0),
      child: Text(
        title,
        style: TextStyle(
          color: leading == null ? colorPrimary : colorBlack,
          fontSize: leading == null ? 16.sp : 14.5.sp,
        ),
      ),
    ),
    actions: actions,
  );
}
