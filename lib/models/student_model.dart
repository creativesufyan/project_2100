// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Student {
  final String name;
  final String section;
  final String series;
  final String roll;
  Student({
    required this.name,
    required this.section,
    required this.series,
    required this.roll,
  });

  Student copyWith({
    String? name,
    String? section,
    String? series,
    String? roll,
  }) {
    return Student(
      name: name ?? this.name,
      section: section ?? this.section,
      series: series ?? this.series,
      roll: roll ?? this.roll,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'section': section,
      'series': series,
      'roll': roll,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      name: map['name'] as String,
      section: map['section'] as String,
      series: map['series'] as String,
      roll: map['roll'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Student(name: $name, section: $section, series: $series, roll: $roll)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.section == section &&
        other.series == series &&
        other.roll == roll;
  }

  @override
  int get hashCode {
    return name.hashCode ^ section.hashCode ^ series.hashCode ^ roll.hashCode;
  }
}
