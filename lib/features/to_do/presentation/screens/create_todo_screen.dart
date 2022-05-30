import 'package:assignment_manabie/core/common/widgets/app_bar_common.dart';
import 'package:assignment_manabie/core/common/widgets/dialogs/dialog_loading.dart';
import 'package:assignment_manabie/core/common/widgets/text_form_field_custom.dart';
import 'package:assignment_manabie/core/routes/app_pages.dart';
import 'package:assignment_manabie/core/routes/app_routes.dart';
import 'package:assignment_manabie/core/styles/home_style.dart';
import 'package:assignment_manabie/core/usecases/usecase.dart';
import 'package:assignment_manabie/core/utils/sizer_custom/sizer.dart';
import 'package:assignment_manabie/features/to_do/data/models/app_state.dart';
import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';
import 'package:assignment_manabie/features/to_do/domain/usecases/create_todo.dart';
import 'package:assignment_manabie/features/to_do/domain/usecases/update_todo.dart';
import 'package:assignment_manabie/features/to_do/presentation/redux/actions.dart';
import 'package:assignment_manabie/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:redux/redux.dart';

class CreateTodoScreen extends StatefulWidget {
  final TodoModel? todoModel;
  const CreateTodoScreen({Key? key, this.todoModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subTitleController = TextEditingController();
  late final bool _isEditing = widget.todoModel != null;

  @override
  void initState() {
    super.initState();

    if (widget.todoModel != null) {
      _titleController.text = widget.todoModel!.title;
      _subTitleController.text = widget.todoModel!.subTitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCommon(
        title: '${(_isEditing ? 'Update' : 'Create')} Todo',
        leading: IconButton(
          onPressed: () {
            AppNavigator.pop();
          },
          icon: Icon(
            PhosphorIcons.caretLeft,
            size: 20.sp,
            color: colorBlack,
          ),
        ),
        actions: [
          StoreConnector<AppState, Function(TodoModel)>(builder: (context, callBack) {
            return IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  showDialogLoading();
                  if (_isEditing) {
                    final TodoModel todo = TodoModel(
                      id: widget.todoModel!.id,
                      title: _titleController.text,
                      subTitle: _subTitleController.text,
                      isDone: widget.todoModel!.isDone,
                      createdAt: widget.todoModel!.createdAt,
                    );
                    callBack(todo);
                    sl<UpdateTodo>().call(Params(todo: todo));
                  } else {
                    final TodoModel todo = TodoModel(
                      title: _titleController.text,
                      subTitle: _subTitleController.text,
                      isDone: false,
                      createdAt: DateTime.now(),
                      id: DateTime.now().microsecondsSinceEpoch.toString(),
                    );
                    callBack(todo);
                    sl<CreateTodo>().call(Params(todo: todo));
                  }
                  AppNavigator.popUntil(Routes.root);
                }
              },
              icon: Icon(
                PhosphorIcons.check,
                size: 20.sp,
                color: colorPrimary,
              ),
            );
          }, converter: (Store<AppState> store) {
            return (TodoModel todo) => store.dispatch(
                _isEditing ? UpdateTodoAction(todoModel: todo) : CreateTodoAction(todoModel: todo));
          })
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              SizedBox(height: 12.sp),
              Text(
                'Title',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: colorPrimary,
                ),
              ),
              TextFieldFormRequest(
                controller: _titleController,
                hintText: 'Title',
                maxLines: 1,
                validatorForm: (val) =>
                    val!.isEmpty || val.trim().length == 0 ? 'Please enter title' : null,
              ),
              SizedBox(height: 12.sp),
              Text(
                'Sub Title',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: colorPrimary,
                ),
              ),
              TextFieldFormRequest(
                controller: _subTitleController,
                hintText: 'Sub Title',
                maxLines: 1,
                validatorForm: (val) =>
                    val!.isEmpty || val.trim().length == 0 ? 'Please enter sub title' : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
