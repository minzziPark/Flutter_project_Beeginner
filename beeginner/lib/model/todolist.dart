import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Todo {
  String? id;
  late String todoTitle;
  late bool checked;
  String? uid;

  Todo({
    this.id,
    required this.todoTitle,
    required this.checked,
    this.uid,
  });

  Todo.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todoTitle = json['todoTitle'];
    checked = json['checked'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson(Todo todo) => {
        'id': id,
        'todoTitle': todoTitle,
        'checked': checked,
        'uid': uid,
      };
}
