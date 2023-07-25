// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CourseAttendanceModel {
  final Set<String> present;
  final Set<String> absent;
  final Set<String> late;
  final String dateTime;
  CourseAttendanceModel({
    required this.present,
    required this.absent,
    required this.late,
    required this.dateTime,
  });

  CourseAttendanceModel copyWith({
    Set<String>? present,
    Set<String>? absent,
    Set<String>? late,
    String? dateTime,
  }) {
    return CourseAttendanceModel(
      present: present ?? this.present,
      absent: absent ?? this.absent,
      late: late ?? this.late,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'present': present.toList(),
      'absent': absent.toList(),
      'late': late.toList(),
      'dateTime': dateTime,
    };
  }

  factory CourseAttendanceModel.fromMap(Map<String, dynamic> map) {
    return CourseAttendanceModel(
      present: Set<String>.from((map['present'] as Set<String>)),
      absent: Set<String>.from((map['absent'] as Set<String>)),
      late: Set<String>.from((map['late'] as Set<String>)),
      dateTime: map['dateTime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseAttendanceModel.fromJson(String source) =>
      CourseAttendanceModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CourseAttendanceModel(present: $present, absent: $absent, late: $late, dateTime: $dateTime)';
  }

  @override
  bool operator ==(covariant CourseAttendanceModel other) {
    if (identical(this, other)) return true;

    return setEquals(other.present, present) &&
        setEquals(other.absent, absent) &&
        setEquals(other.late, late) &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return present.hashCode ^
        absent.hashCode ^
        late.hashCode ^
        dateTime.hashCode;
  }
}
