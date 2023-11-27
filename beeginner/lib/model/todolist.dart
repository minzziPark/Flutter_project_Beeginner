import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Todo {
  String? id;
  late String todoTitle;
  late bool checked;

  Todo({
    this.id,
    required this.todoTitle,
    required this.checked,
  });

  Todo.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todoTitle = json['todoTitle'];
    checked = json['checked'];
  }

  Map<String, dynamic> toJson(Todo todo) => {
        'id': id,
        'todoTitle': todoTitle,
        'checked': checked,
      };
}
