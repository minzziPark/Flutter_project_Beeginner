import 'package:beeginner/model/todolist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseController {
  static get collection => FirebaseFirestore.instance.collection('todo');

  static void add(Todo todo) => collection.add(todo.toJson(todo));
  static void update(Todo todo) =>
      collection.doc(todo.id).set(todo.toJson(todo));
  static void delete(String id) => collection.doc(id).delete();
}
