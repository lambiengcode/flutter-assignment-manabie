import 'package:assignment_manabie/core/common/widgets/touchable_opacity.dart';
import 'package:assignment_manabie/core/styles/style.dart';
import 'package:assignment_manabie/core/utils/sizer_custom/sizer.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isChecked;
  final Function(bool)? onChanged;
  const CustomCheckBox({Key? key, required this.isChecked, this.onChanged}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        if (onChanged != null) {
          onChanged!(!isChecked);
        }
      },
      child: Container(
        height: 20.sp,
        width: 20.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.sp),
          border: Border.all(color: colorDarkGrey, width: 0.5),
        ),
        alignment: Alignment.center,
        child: isChecked
            ? Icon(Icons.check_rounded, color: colorPrimary, size: 12.sp)
            : null,
      ),
    );
  }
}
