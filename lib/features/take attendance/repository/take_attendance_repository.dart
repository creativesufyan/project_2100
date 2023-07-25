import 'package:attendance_app/core/providers/sign_in_provider.dart';
import 'package:attendance_app/models/course_attendance_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/failure.dart';
import '../../../core/typedefs.dart';
import '../../../models/student_model.dart';

final TakeAttendanceRepositoryProvider =
    Provider<TakeAttendanceRepository>((ref) {
  return TakeAttendanceRepository(firestore: ref.read(firestoreProvider));
});

class TakeAttendanceRepository {
  final FirebaseFirestore _firestore;

  TakeAttendanceRepository({required final FirebaseFirestore firestore})
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

  FutureVoid takeAttendance(
      CourseAttendanceModel courseAttendanceModel, String name) async {
    try {
      var dateTimeDoc = await _courses
          .doc(name)
          .collection('dates')
          .doc(courseAttendanceModel.dateTime)
          .get();
      if (dateTimeDoc.exists) {
        throw 'Attendance for this day is already taken!!';
      }

      return right(_courses
          .doc(name)
          .collection('dates')
          .doc(courseAttendanceModel.dateTime)
          .set(courseAttendanceModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  CollectionReference get _courses =>
      _firestore.collection(FirebaseConstants.coursesCollection);
  CollectionReference get _students =>
      _firestore.collection(FirebaseConstants.studentsCollection);
}
