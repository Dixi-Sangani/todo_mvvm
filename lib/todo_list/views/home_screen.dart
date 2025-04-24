import 'package:demo_project/components/components.dart';
import 'package:demo_project/todo_list/view_models/todo_view_model.dart';
import 'package:demo_project/todo_list/views/views.dart';
import 'package:demo_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TodoViewModels todoViewModels = context.watch<TodoViewModels>();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("To-Do List",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todoViewModels.resetData();
          Navigator.push(context,
              MaterialPageRoute(builder: (_) {
                return AddTodoList();
              }));
        },
        backgroundColor: bgRedColor,
        child: const Center(
          child: Icon(Icons.add),
        ),

      ),
      body: todoViewModels.todoListModel.isEmpty ? const Padding(
        padding: EdgeInsets.only(top: 30),
        child: Align(
          alignment: Alignment(0,-0.8),
          child: Text(
            "No records found",
            style: TextStyle(fontSize: 20),
          ),
        ),
      )
          : ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: todoViewModels.todoListModel.length,
        itemBuilder: (BuildContext context, int index) {
          final todoItem = todoViewModels.todoListModel[index];
          return TodoListRow(todoListModel: todoItem,index: index,);
        },
      ),
    );
  }
}
