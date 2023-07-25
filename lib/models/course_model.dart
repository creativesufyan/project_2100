// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Course {
  final String name;
  final String banner;
  final String author;
  final String courseName;
  final String series;
  final String section;
  Course({
    required this.name,
    required this.banner,
    required this.author,
    required this.courseName,
    required this.series,
    required this.section,
  });

  Course copyWith({
    String? name,
    String? banner,
    String? author,
    String? courseName,
    String? series,
    String? section,
  }) {
    return Course(
      name: name ?? this.name,
      banner: banner ?? this.banner,
      author: author ?? this.author,
      courseName: courseName ?? this.courseName,
      series: series ?? this.series,
      section: section ?? this.section,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'banner': banner,
      'author': author,
      'courseName': courseName,
      'series': series,
      'section': section,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      name: map['name'] as String,
      banner: map['banner'] as String,
      author: map['author'] as String,
      courseName: map['courseName'] as String,
      series: map['series'] as String,
      section: map['section'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) =>
      Course.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Course(name: $name, banner: $banner, author: $author, courseName: $courseName, series: $series, section: $section)';
  }

  @override
  bool operator ==(covariant Course other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.banner == banner &&
        other.author == author &&
        other.courseName == courseName &&
        other.series == series &&
        other.section == section;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        banner.hashCode ^
        author.hashCode ^
        courseName.hashCode ^
        series.hashCode ^
        section.hashCode;
  }
}
