import 'package:demo_project/todo_list/model/model.dart';
import 'package:flutter/material.dart';


class TodoViewModels extends ChangeNotifier {
  final List<TodoListModel> _todoListModel = [];
  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now();
  final TextEditingController _todoTitle = TextEditingController();
  TodoListModel? _currentTodoModel;

  List<TodoListModel> get todoListModel => _todoListModel;
  DateTime get startDateTime => _startDateTime;
  DateTime get endDateTime => _endDateTime;
  TextEditingController get todoTitle => _todoTitle;
  TodoListModel? get currentTodoModel => _currentTodoModel;

  setCurrentTodoModel(TodoListModel todoListModel){
    _startDateTime = todoListModel.startDate!;
    _endDateTime = todoListModel.endDate!;
    _todoTitle.text = todoListModel.title;
  }

  resetData(){
    _startDateTime = DateTime.now();
    _endDateTime = DateTime.now();
    _todoTitle.clear();
    notifyListeners();
  }

  setTodoListModel(TodoListModel todoListModel){
    _todoListModel.add(todoListModel);
    notifyListeners();
  }

  setTodoListCompleted(bool isCompleted,int index){
    _todoListModel[index].status = isCompleted;
    notifyListeners();
  }

  setTodoListItem(TodoListModel todoListModel,int index){
    _todoListModel[index] = todoListModel;
    notifyListeners();
  }

  setStartDateTime(DateTime dateTime){
    _startDateTime = dateTime;
    notifyListeners();
  }

  setEndDateTime(DateTime dateTime){
    _endDateTime = dateTime;
    notifyListeners();
  }

  setNewDateTime(DateTime dateTime,int dateTimeIndicator){
    dateTimeIndicator == 0 ? _startDateTime = dateTime : _endDateTime = dateTime;
    notifyListeners();
  }

  setTodoTitle(String todoTitle){
    _todoTitle.text = todoTitle;
    notifyListeners();
  }
}