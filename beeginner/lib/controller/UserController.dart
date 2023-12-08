import 'package:beeginner/model/userlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {
  static get collection => FirebaseFirestore.instance.collection('user');

  static void add(Users user) => collection.add(user.toJson(user));
  static void update(Users user) =>
      collection.doc(user.uid).set(user.toJson(user));
  static void delete(String id) => collection.doc(id).delete();
}
