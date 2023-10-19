import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/models/enums/operation.dart';

class OperationRecord {
  int? id;
  DateTime time;
  final Operation operation;

  OperationRecord({
    this.id,
    required this.time,
    required this.operation,
  });

  factory OperationRecord.fromJson(Map<dynamic, dynamic> json) {
    return OperationRecord(
      id: json['id'],
      time: DateTime.parse(json['time']),
      operation: Operation.values
          .firstWhere((op) => op.toString() == json['operation']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time.toIso8601String(),
      'operation': operation.toString(),
    };
  }
}
