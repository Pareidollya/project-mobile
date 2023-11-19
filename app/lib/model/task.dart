class Task {
  String id;
  String title;
  String date;
  String status;
  bool completed;
  String userId;

  Task({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
    required this.completed,
    required this.userId,
  });

  copyWith({
    String? id,
    String? title,
    String? date,
    String? status,
    bool? completed,
    String? userId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      status: status ?? this.status,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }
  
}