
import 'package:flutter/cupertino.dart';

class Countdown {
  int id;
  int time;
  String count;
  int total;
  int status;


  Countdown({required this.id, required this.time, required this.count,
    required this.total, required this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time,
      'count': count,
      'total': total,
      'status': status
    };
  }

  static Countdown fromMap(Map<String, dynamic> map) {
    return Countdown(
      id: map['id'],
      time: map['time'],
      count: map['count'],
      total: map['total'],
      status: map['status']
    );
  }
}

class TimerData {
  TextEditingController count;
  int status;

  TimerData({ required this.count,
     required this.status});

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'status': status
    };
  }

  static TimerData fromMap(Map<String, dynamic> map) {
    return TimerData(
      count: map['count'],
      status: map['status']
    );
  }
}
