import 'package:beeginner/model/schedulelist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleController {
  static get collection => FirebaseFirestore.instance.collection('schedule');

  static void add(Schedule schedule) =>
      collection.add(schedule.toJson(schedule));
  static void update(Schedule schedule) =>
      collection.doc(schedule.id).set(schedule.toJson(schedule));
  static void delete(String id) => collection.doc(id).delete();
}
