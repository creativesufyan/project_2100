import 'package:flutter/material.dart';

import 'filter_chip_data.dart';

class FilterChips {
  static final all = <FilterChipData>[
    FilterChipData(label: "All", color: Colors.white, isSelected: true),
    FilterChipData(label: "Present", color: Colors.white, isSelected: false),
    FilterChipData(label: "Absent", color: Colors.white, isSelected: false),
    FilterChipData(label: "Late", color: Colors.white, isSelected: false),
  ];
}
