import 'package:demo_project/components/components.dart';
import 'package:demo_project/todo_list/model/model.dart';
import 'package:demo_project/todo_list/views/views.dart';
import 'package:demo_project/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TodoListRow extends StatelessWidget {
  TodoListModel todoListModel;
  int index;

  TodoListRow({super.key, required this.todoListModel,required this.index});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddTodoList(todoListModel: todoListModel,index: index,)));
      },
      child: Align(
        alignment: const Alignment(0,-0.8),
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          height: 180,
          width: screenWidth*0.9,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(todoListModel.title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                  )),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 10),
                  child: Row(
                    children: [
                      TodoListRowDate(
                        "Start Date:",
                        DateFormat('dd MMM yyyy').format(todoListModel.startDate!),
                      ),
                      TodoListRowDate(
                        "End Date:",
                        DateFormat('dd MMM yyyy').format(todoListModel.endDate!),
                      ),
                      TodoListRowDate(
                        "Time Left:",
                        todoListModel.timeLeft,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(left: 20,right: 10),
                  decoration: BoxDecoration(
                    color: todoListModel.status ? primaryColor.withOpacity(0.5) : Color(0xFFe8e3d1),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                  ),
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                              text: 'Status: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          TextSpan(
                              text: todoListModel.status ? 'Complete' : 'Incomplete',
                              style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,)),
                        ]),
                      ),
                      const Spacer(),
                      const Text("Tick if completed",),
                      TodoListRowCheckBox(index: index,),
                    ],
                  ),
                ),
              )],
          ),
        ),
      ),
    );
  }
}
