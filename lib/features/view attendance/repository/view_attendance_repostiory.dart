import 'package:attendance_app/models/course_attendance_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/providers/sign_in_provider.dart';
import '../../../models/student_model.dart';

final viewAttendanceRepositoryProvider =
    Provider<ViewAttendanceRepository>((ref) {
  return ViewAttendanceRepository(firestore: ref.read(firestoreProvider));
});

class ViewAttendanceRepository {
  final FirebaseFirestore _firestore;
  ViewAttendanceRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Stream<List<Student>> getStudentList(String section) {
    return _students
        .doc('cse')
        .collection(section)
        .where("section", isEqualTo: section)
        .snapshots()
        .map((event) {
      List<Student> students = [];
      for (var doc in event.docs) {
        students.add(Student.fromMap(doc.data()));
      }
      return students;
    });
  }

  Stream<List<CourseAttendanceModel>> getAttendanceList(String name) {
    return _courses.doc(name).collection('dates').snapshots().map((event) {
      List<CourseAttendanceModel> attendanceList = [];
      for (var doc in event.docs) {
        attendanceList.add(CourseAttendanceModel.fromMap(doc.data()));
      }
      return attendanceList;
    });
  }

  CollectionReference get _courses =>
      _firestore.collection(FirebaseConstants.coursesCollection);
  CollectionReference get _students =>
      _firestore.collection(FirebaseConstants.studentsCollection);
}
