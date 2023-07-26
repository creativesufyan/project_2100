import 'package:attendance_app/models/course_attendance_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/student_model.dart';
import '../repository/view_attendance_repostiory.dart';

final getStudentListProvider = StreamProvider.family((ref, String section) {
  return ref
      .watch(viewAttendanceControllerProvider.notifier)
      .getStudentList(section);
});
final getAttendanceListProvider = StreamProvider.family((ref, String name) {
  return ref
      .watch(viewAttendanceControllerProvider.notifier)
      .getAttendanceList(name);
});

final viewAttendanceControllerProvider =
    StateNotifierProvider<ViewAttendanceController, bool>((ref) {
  return ViewAttendanceController(
      viewAttendanceRepository: ref.read(viewAttendanceRepositoryProvider));
});

class ViewAttendanceController extends StateNotifier<bool> {
  final ViewAttendanceRepository _viewAttendanceRepository;
  ViewAttendanceController(
      {required ViewAttendanceRepository viewAttendanceRepository})
      : _viewAttendanceRepository = viewAttendanceRepository,
        super(false);

  Stream<List<Student>> getStudentList(String section) {
    return _viewAttendanceRepository.getStudentList(section);
  }

  Stream<List<CourseAttendanceModel>> getAttendanceList(String name) {
    return _viewAttendanceRepository.getAttendanceList(name);
  }
}
