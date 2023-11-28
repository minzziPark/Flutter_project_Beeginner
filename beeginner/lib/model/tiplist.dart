import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Tip {
  String? id;
  late String tipTitle;
  late bool star;
  late String discription;
  Timestamp? createTime;

  Tip({
    this.id,
    required this.tipTitle,
    required this.star,
    required this.discription,
    Timestamp? createTime,
  });

  Tip.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipTitle = json['tipTitle'];
    star = json['star'];
    discription = json['discription'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson(Tip tip) => {
        'id': id,
        'tipTitle': tipTitle,
        'star': star,
        'discription': discription,
        'createTime': createTime,
      };
}
