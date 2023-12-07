import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Schedule {
  String? id;
  Timestamp? date;
  late String time;
  late String memo;

  Schedule({
    this.id,
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
  }

  Map<String, dynamic> toJson(Schedule schedule) => {
        'id': id,
        'date': date,
        'time': time,
        'memo': memo,
      };
}
