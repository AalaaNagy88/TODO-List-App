
class TodoModel {
  int id;
  String name;
  String details;
  String date;
  String time;
  int done;

  TodoModel(
      {this.id, this.name, this.details, this.date, this.time, this.done});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "done": done,
      "details": details,
      "date": date,
      "time": time
    };
  }

  factory TodoModel.fromMap(final map) {
    return TodoModel(
        id: map["id"],
        name: map["name"],
        details: map["details"],
        date: map["date"],
        time: map["time"],
        done: map["done"]);
  }
}
