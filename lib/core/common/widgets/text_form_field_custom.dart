import 'package:assignment_manabie/core/common/app_colors.dart';
import 'package:assignment_manabie/core/styles/style.dart';
import 'package:assignment_manabie/core/utils/sizer_custom/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldFormRequest extends StatelessWidget {
  final String? Function(String?)? validatorForm;
  final void Function(String)? onChanged;
  final String hintText;
  final int maxLines;
  final int? maxLength;
  final bool isAvailable;
  final bool isActive;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final FocusNode? focusNode;
  final Color? colorTextField;
  final void Function()? onTap;
  TextFieldFormRequest({
    required this.validatorForm,
    required this.hintText,
    this.textInputType,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.isAvailable = true,
    this.isActive = true,
    this.controller,
    this.suffixIcon,
    this.inputFormatters,
    this.focusNode,
    this.colorTextField,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: maxLength != null ? 0.0 : 10.sp),
      width: double.infinity,
      child: TextFormField(
        onTap: onTap ?? () {},
        focusNode: focusNode,
        controller: controller,
        enabled: isAvailable && isActive,
        validator: validatorForm,
        style: TextStyle(
          fontSize: 12.sp,
          color: isAvailable ? colorBlack : colorDarkGrey,
        ),
        cursorColor: colorPrimary,
        keyboardType:
            textInputType != null ? textInputType : TextInputType.multiline,
        onChanged: onChanged,
        maxLines: maxLines == 1 ? null : maxLines,
        inputFormatters: inputFormatters ??
            [
              LengthLimitingTextInputFormatter(maxLength),
            ],
        decoration: InputDecoration(
          filled: true,
          fillColor: isAvailable ? Colors.white : mCD,
          hintText: hintText,
          focusedBorder: maxLength != null
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.sp),
                  borderSide: BorderSide(
                    color: mCD,
                    width: 0.5.sp,
                  ),
                ),
          border: maxLength != null
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.sp),
                  borderSide: BorderSide(
                    color: mCD,
                    width: 0.5.sp,
                  ),
                ),
          enabledBorder: maxLength != null
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.sp),
                  borderSide: BorderSide(
                    color: mCD,
                    width: 0.5.sp,
                  ),
                ),
          disabledBorder: maxLength != null
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.sp),
                  borderSide: BorderSide(
                    color: mCD,
                    width: 0.5.sp,
                  ),
                ),
          hintStyle: TextStyle(
            color: colorDarkGrey,
            fontSize: 12.sp,
          ),
          isDense: maxLines == 1,
          contentPadding: maxLines == 1
              ? EdgeInsets.symmetric(
                  vertical: 11.sp,
                  horizontal: 10.sp,
                )
              : EdgeInsets.symmetric(
                  vertical: 8.sp,
                  horizontal: 10.sp,
                ),
          suffix: suffixIcon == null
              ? null
              : Padding(
                  padding: EdgeInsets.only(bottom: 1.25.sp),
                  child: suffixIcon,
                ),
        ),
      ),
    );
  }
}
