import 'package:demo_project/components/components.dart';
import 'package:demo_project/todo_list/model/model.dart';
import 'package:demo_project/todo_list/view_models/view_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constant.dart';

class AddTodoList extends StatelessWidget {
  TodoListModel? todoListModel;
  int? index;
  AddTodoList({super.key, this.todoListModel, this.index});
  final _formKey = GlobalKey<FormState>();

  //FUNCTIONS
  Future<DateTime?> pickDate(TodoViewModels todoViewModels, int dateTimeIndicator, BuildContext context) =>
      showDatePicker(
        context: context,
        initialDate: dateTimeIndicator == 0 ? todoViewModels.startDateTime : todoViewModels.endDateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickTime(
          TodoViewModels todoViewModels, int dateTimeIndicator, BuildContext context) =>
      showTimePicker(
          context: context,
          initialTime: dateTimeIndicator == 0
              ? TimeOfDay(hour: todoViewModels.startDateTime.hour, minute: todoViewModels.startDateTime.minute)
              : TimeOfDay(hour: todoViewModels.endDateTime.hour, minute: todoViewModels.endDateTime.minute));

  Future pickDateTime(int dateTimeIndicator, TodoViewModels todoViewModels, BuildContext context) async {
    DateTime? date = await pickDate(todoViewModels, dateTimeIndicator, context);
    if (date == null) return; //pressed CANCEL;

    TimeOfDay? time = await pickTime(todoViewModels, dateTimeIndicator, context);
    if (time == null) return; //pressed CANCEL;

    final newDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    todoViewModels.setNewDateTime(newDateTime, dateTimeIndicator);
  }

  String daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day, from.hour, from.minute);
    to = DateTime(to.year, to.month, to.day, to.hour, to.minute);
    // print(to.difference(from).inHours);
    // print(to.difference(from).inMinutes % 60);
    return ('${to.difference(from).inHours} hrs ${to.difference(from).inMinutes % 60} min');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TodoViewModels todoViewModels = context.watch<TodoViewModels>();
    if (todoListModel != null) {
      todoViewModels.setCurrentTodoModel(todoListModel!);
    }
    final hoursStart = todoViewModels.startDateTime.hour.toString().padLeft(2, '0');
    final minutesStart = todoViewModels.startDateTime.minute.toString().padLeft(2, '0');
    final hoursEnd = todoViewModels.endDateTime.hour.toString().padLeft(2, '0');
    final minutesEnd = todoViewModels.endDateTime.minute.toString().padLeft(2, '0');

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: const Text(
              "Add New To-Do List",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: primaryColor,
            centerTitle: false,
            automaticallyImplyLeading: true,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(screenWidth, 70),
                primary: Colors.black,
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final timeLeft = daysBetween(todoViewModels.startDateTime, todoViewModels.endDateTime);
                    final newTodoListModel = TodoListModel(
                      title: todoViewModels.todoTitle.text,
                      startDate: todoViewModels.startDateTime,
                      endDate: todoViewModels.endDateTime,
                      timeLeft: timeLeft,
                      status: false,
                    );

                    todoListModel != null
                        ? todoViewModels.setTodoListItem(newTodoListModel, index!)
                        : todoViewModels.setTodoListModel(newTodoListModel);
                    Navigator.of(context).pop();
                  }
              },
              child: Text(
                todoListModel != null ? 'Edit To-Do' : 'Create To-Do',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          body: Align(
            alignment: const Alignment(0, 0),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 10, top: 20),
                height: screenHeight * 0.8,
                width: screenWidth * 0.85,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddTodoListLabel(label: "To-Do Title"),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: todoViewModels.todoTitle,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Please add your To Do title here',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'To-Do Field is required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Trigger live validation
                        if (_formKey.currentState != null) {
                          _formKey.currentState!.validate();
                        }
                      },
                      onSaved: (value) {
                        todoViewModels.todoTitle.text = value!;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AddTodoListLabel(label: "Start Date"),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await pickDateTime(0, todoViewModels, context); // 0-start
                      },
                      style: ElevatedButton.styleFrom(
                        //backgroundColor: Colors.white,
                        elevation: 2.0,
                        side: const BorderSide(color: Colors.grey),
                        minimumSize: const Size(200, 60),
                      ),
                      child: Text(
                        '${todoViewModels.startDateTime.day}/${todoViewModels.startDateTime.month}/${todoViewModels.startDateTime.year} $hoursStart:$minutesStart',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AddTodoListLabel(label: "Estimated End Date"),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await pickDateTime(1, todoViewModels, context); // 1-end
                      },
                      style: ElevatedButton.styleFrom(
                        //backgroundColor: Colors.white,
                        elevation: 2.0,
                        side: const BorderSide(color: Colors.grey),
                        minimumSize: const Size(200, 60),
                      ),
                      child: Text(
                        '${todoViewModels.endDateTime.day}/${todoViewModels.endDateTime.month}/${todoViewModels.endDateTime.year} $hoursEnd:$minutesEnd',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
