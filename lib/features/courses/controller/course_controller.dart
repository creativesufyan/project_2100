import 'package:attendance_app/features/auth/controllers/auth_controller.dart';
import 'package:attendance_app/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils.dart';
import '../repository/course_repository.dart';

final teacherCourseProvider = StreamProvider((ref) {
  final courseController = ref.watch(courseControllerProvider.notifier);
  return courseController.getUserCommunities();
});

final courseControllerProvider =
    StateNotifierProvider<CourseController, bool>((ref) {
  final courseRepository = ref.watch(courseRepositoryProvider);

  return CourseController(
    courseRepository: courseRepository,
    ref: ref,
  );
});

class CourseController extends StateNotifier<bool> {
  final CourseRepository _courseRepository;
  final Ref _ref;
  CourseController({
    required CourseRepository courseRepository,
    required Ref ref,
  })  : _courseRepository = courseRepository,
        _ref = ref,
        super(false);

  void createCourse(String name, String courseName, String series,
      String section, BuildContext context) async {
    state = true;
    final uid = _ref.read(teacherProvider)?.uid ?? '';
    Course course = Course(
      name: name,
      banner: Constants.bannerDefault,
      author: uid,
      courseName: courseName,
      section: section,
      series: series,
    );

    final res = await _courseRepository.createCommunity(course);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Course created successfully!');
      Routemaster.of(context).pop();
    });
  }

  Stream<List<Course>> getUserCommunities() {
    final uid = _ref.read(teacherProvider)!.uid;
    return _courseRepository.getUserCommunities(uid);
  }
}
