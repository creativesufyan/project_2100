import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils.dart';
import '../../../models/course_attendance_model.dart';
import '../../../models/student_model.dart';
import '../repository/take_attendance_repository.dart';

final getStudentListProvider = StreamProvider.family((ref, String section) {
  return ref
      .watch(takeAttendanceControllerProvider.notifier)
      .getStudentList(section);
});

final takeAttendanceControllerProvider =
    StateNotifierProvider<TakeAttendanceController, bool>((ref) {
  return TakeAttendanceController(
      takeAttendanceRepository: ref.read(takeAttendanceRepositoryProvider));
});

class TakeAttendanceController extends StateNotifier<bool> {
  final TakeAttendanceRepository _takeAttendanceRepository;
  TakeAttendanceController(
      {required TakeAttendanceRepository takeAttendanceRepository})
      : _takeAttendanceRepository = takeAttendanceRepository,
        super(false);

  void takeAttendance(Set<String> present, Set<String> absent, Set<String> late,
      String dateTime, String name, BuildContext context) async {
    state = true;
    CourseAttendanceModel courseAttendanceModel = CourseAttendanceModel(
        present: present, absent: absent, late: late, dateTime: dateTime);

    // StudentAttendanceModel studentAttendanceModel = StudentAttendanceModel(
    //     present: present, absent: absent, late: late, courseName: name);

    final res = await _takeAttendanceRepository.takeAttendance(
        courseAttendanceModel, name);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Attendance submitted successfully!');
      // Routemaster.of(context).pop();
    });
  }

  Stream<List<Student>> getStudentList(String section) {
    return _takeAttendanceRepository.getStudentList(section);
  }
}
