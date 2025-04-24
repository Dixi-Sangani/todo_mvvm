class TodoListModel {
  String title = "";
  DateTime? startDate;
  DateTime? endDate;
  String timeLeft = "";
  bool status = false;

  TodoListModel({required this.title, required this.startDate, required this.endDate, required this.timeLeft, required this.status});
}