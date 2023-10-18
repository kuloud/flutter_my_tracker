import 'package:flutter/material.dart';

class OperationRecord {
  int? id;
  DateTime time;
  final Action action;

  OperationRecord({
    this.id,
    required this.time,
    required this.action,
  });

  factory OperationRecord.fromJson(Map<dynamic, dynamic> json) {
    return OperationRecord(
      id: json['id'],
      time: json['time'],
      action: json['action'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time,
      'action': action,
    };
  }
}
