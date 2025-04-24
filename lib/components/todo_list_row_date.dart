import 'package:flutter/material.dart';

class TodoListRowDate extends StatelessWidget {
  String subTitle = "";
  String item = "";

  TodoListRowDate(this.subTitle,this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subTitle,style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),),
          Text(item,style: const TextStyle(fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}
