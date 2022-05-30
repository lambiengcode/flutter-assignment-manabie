import 'package:assignment_manabie/core/common/widgets/pagination_list_view.dart';
import 'package:assignment_manabie/features/to_do/data/models/todo_model.dart';
import 'package:assignment_manabie/features/to_do/presentation/widgets/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:assignment_manabie/core/utils/sizer_custom/sizer.dart';

class TodoList extends StatefulWidget {
  final List<TodoModel> todos;
  final Function(TodoModel, bool) onCheckboxChanged;
  final Function(TodoModel) onRemove;
  const TodoList({
    Key? key,
    required this.todos,
    required this.onCheckboxChanged,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: PaginationListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 20.sp),
        itemCount: widget.todos.length,
        itemBuilder: (context, index) {
          return TodoCard(
            todoModel: widget.todos[index],
            onCheckboxChanged: widget.onCheckboxChanged,
            onRemove: widget.onRemove,
          );
        },
        childShimmer: Container(),
      ),
    );
  }
}
