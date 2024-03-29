
class Task {
  static const String collectionName = "tasks";
  String? id;
  String ?title;
  String ?description;
  DateTime? dateTime;
  bool ?isDone;

  Task({
    this.id = '',
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false,
  });
  Task.fromFireStore(Map<String,dynamic> data):this(
  title: data['title'] as String,
  description: data['description'] as String,
  dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
  id: data['id'] as String,
  isDone: data['isDone'],
);
  Map<String, dynamic> toFireStore() {
    return {
      'id' : id,
      'title' : title,
      'description' : description,
      'dateTime' : dateTime?.millisecondsSinceEpoch,
      'isDone' : isDone,
    };
  }
}
