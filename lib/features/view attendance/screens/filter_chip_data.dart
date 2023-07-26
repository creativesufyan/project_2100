// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class FilterChipData {
  final String label;
  final Color color;
  final bool isSelected;
  FilterChipData({
    required this.label,
    required this.color,
    required this.isSelected,
  });

  FilterChipData copyWith({
    String? label,
    Color? color,
    bool? isSelected,
  }) {
    return FilterChipData(
      label: label ?? this.label,
      color: color ?? this.color,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'color': color.value,
      'isSelected': isSelected,
    };
  }

  factory FilterChipData.fromMap(Map<String, dynamic> map) {
    return FilterChipData(
      label: map['label'] as String,
      color: Color(map['color'] as int),
      isSelected: map['isSelected'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterChipData.fromJson(String source) =>
      FilterChipData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FilterChipData(label: $label, color: $color, isSelected: $isSelected)';

  @override
  bool operator ==(covariant FilterChipData other) {
    if (identical(this, other)) return true;

    return other.label == label &&
        other.color == color &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode => label.hashCode ^ color.hashCode ^ isSelected.hashCode;
}
