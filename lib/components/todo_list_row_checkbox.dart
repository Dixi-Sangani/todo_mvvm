import 'package:demo_project/todo_list/view_models/view_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TodoListRowCheckBox extends StatefulWidget {
  int index;

  TodoListRowCheckBox({super.key, required this.index});

  @override
  State<TodoListRowCheckBox> createState() => _TodoListRowCheckBoxState();
}

class _TodoListRowCheckBoxState extends State<TodoListRowCheckBox> {

  bool isCheckedCompleted = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.black;
    }

    TodoViewModels todoViewModels = context.watch<TodoViewModels>();

    return Transform.scale(
      scale: 1.0,
      child: Checkbox(
        value: isCheckedCompleted, // boolCategory[i]
        fillColor: MaterialStateProperty.resolveWith(getColor),
        checkColor: Colors.white,
        onChanged: (bool? value){
          isCheckedCompleted = value!;
          todoViewModels.setTodoListCompleted(value, widget.index);
          setState(() {});
        },
      ),
    );
  }
}
