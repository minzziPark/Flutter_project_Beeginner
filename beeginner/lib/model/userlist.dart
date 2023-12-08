import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class User {
  String? uid;
  late String email;
  late String password;

  User({
    this.uid,
    required this.email,
    required this.password,
  });

  User.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  void fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson(User user) => {
        'uid': uid,
        'email': email,
        'password': password,
      };
}
