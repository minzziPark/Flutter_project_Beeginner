import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  String? id;
  Timestamp? date;
  late String time;
  late String memo;
  String? uid;

  Schedule({
    this.id,
    this.uid,
    required this.date,
    required this.time,
    required this.memo,
  });

  Schedule.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    memo = json['memo'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson(Schedule schedule) => {
        'id': id,
        'date': date,
        'time': time,
        'memo': memo,
        'uid': uid,
      };
}
