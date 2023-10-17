class Task {
  String title;
  String? description;
  bool completed;
  bool important;
  DateTime createdAt;

  Task({
    required this.title,
    this.description,
    this.important = false,
  })  : completed = false,
        createdAt = DateTime.now();

  changeStatus(bool status) {
    completed = status;
  }

  changeimportance() {
    important = !important;
  }
}
