// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class StudentAttendanceModel {
  final Set<String> present;
  final Set<String> absent;
  final Set<String> late;
  final String courseName;
  StudentAttendanceModel({
    required this.present,
    required this.absent,
    required this.late,
    required this.courseName,
  });

  StudentAttendanceModel copyWith({
    Set<String>? present,
    Set<String>? absent,
    Set<String>? late,
    String? courseName,
  }) {
    return StudentAttendanceModel(
      present: present ?? this.present,
      absent: absent ?? this.absent,
      late: late ?? this.late,
      courseName: courseName ?? this.courseName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'present': present.toList(),
      'absent': absent.toList(),
      'late': late.toList(),
      'courseName': courseName,
    };
  }

  factory StudentAttendanceModel.fromMap(Map<String, dynamic> map) {
    return StudentAttendanceModel(
      present: Set<String>.from(
        (map['present'] as Set<String>),
      ),
      absent: Set<String>.from(
        (map['absent'] as Set<String>),
      ),
      late: Set<String>.from(
        (map['late'] as Set<String>),
      ),
      courseName: map['courseName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentAttendanceModel.fromJson(String source) =>
      StudentAttendanceModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StudentAttendanceModel(present: $present, absent: $absent, late: $late, courseName: $courseName)';
  }

  @override
  bool operator ==(covariant StudentAttendanceModel other) {
    if (identical(this, other)) return true;

    return setEquals(other.present, present) &&
        setEquals(other.absent, absent) &&
        setEquals(other.late, late) &&
        other.courseName == courseName;
  }

  @override
  int get hashCode {
    return present.hashCode ^
        absent.hashCode ^
        late.hashCode ^
        courseName.hashCode;
  }
}
