import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Tip {
  String? id;
  late String tipTitle;
  late bool star;
  late String description;
  Timestamp? createTime;
  String? uid;

  Tip({
    this.id,
    this.uid,
    required this.tipTitle,
    required this.star,
    required this.description,
    Timestamp? createTime,
  });

  Tip.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    tipTitle = json['tipTitle'];
    star = json['star'];
    description = json['description'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson(Tip tip) => {
        'id': id,
        'uid': uid,
        'tipTitle': tipTitle,
        'star': star,
        'description': description,
        'createTime': tip.createTime ?? FieldValue.serverTimestamp(),
      };
}
