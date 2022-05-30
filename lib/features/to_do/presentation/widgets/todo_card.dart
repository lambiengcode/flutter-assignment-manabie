import 'package:assignment_manabie/core/common/widgets/app_decoration.dart';
import 'package:assignment_manabie/core/common/widgets/check_box.dart';
import 'package:assignment_manabie/core/common/widgets/dialogs/dialog_loading.dart';
import 'package:assignment_manabie/core/common/widgets/touchable_opacity.dart';
import 'package:assignment_manabie/core/routes/app_pages.dart';
import 'package:assignment_manabie/core/routes/app_routes.dart';
import 'package:assignment_manabie/core/styles/style.dart';
import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:assignment_manabie/core/utils/sizer_custom/sizer.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TodoCard extends StatefulWidget {
  final TodoModel todoModel;
  final Function(TodoModel, bool) onCheckboxChanged;
  final Function(TodoModel) onRemove;
  const TodoCard({
    Key? key,
    required this.todoModel,
    required this.onCheckboxChanged,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () => AppNavigator.push(
        Routes.createTodo,
        arguments: {
          'todoModel': widget.todoModel,
        },
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.sp),
        padding: EdgeInsets.symmetric(vertical: 12.sp),
        decoration: AppDecoration.buttonActionBorder(context, 4.sp).decoration,
        child: Row(
          children: [
            SizedBox(width: 12.sp),
            CustomCheckBox(
              isChecked: widget.todoModel.isDone,
              onChanged: (isChecked) {
                widget.onCheckboxChanged(widget.todoModel, isChecked);
                setState(() {
                  widget.todoModel.isDone = isChecked;
                });
              },
            ),
            SizedBox(width: 12.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.todoModel.title,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: colorPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.sp),
                  Text(
                    widget.todoModel.subTitle,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 10.5.sp,
                      color: colorDarkGrey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.sp),
            IconButton(
              onPressed: () {
                showDialogLoading();
                widget.onRemove(widget.todoModel);
                AppNavigator.popUntil(Routes.root);
              },
              icon: Icon(
                PhosphorIcons.x,
                color: colorBlack,
                size: 18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
