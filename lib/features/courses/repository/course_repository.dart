import 'package:attendance_app/core/providers/sign_in_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/failure.dart';
import '../../../core/typedefs.dart';
import '../../../models/course_model.dart';

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  return CourseRepository(firestore: ref.read(firestoreProvider));
});

class CourseRepository {
  final FirebaseFirestore _firestore;

  CourseRepository({required final FirebaseFirestore firestore})
      : _firestore = firestore;

  FutureVoid createCommunity(Course course) async {
    try {
      var courseDoc = await _courses.doc(course.name).get();
      if (courseDoc.exists) {
        throw 'Community with the same name already exists!';
      }

      return right(_courses.doc(course.name).set(course.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // Future<void> createStudent(
  //     Map<String, Map<String, String>> studentsList) async {
  //   try {
  //     var studentDoc = await _students.doc('cse').get();
  //     if (studentDoc.exists) {
  //       throw 'Community with the same name already exists!';
  //     }
  //     studentsList.entries.forEach((element) async {
  //       _students
  //           .doc('cse')
  //           .collection(element.value.entries.elementAt(1).value)
  //           .doc(element.key)
  //           .set(element.value);
  //     });

  //     // return right(_courses.doc(course.name).set(course.toMap()));
  //   } on FirebaseException catch (e) {
  //     throw e.message!;
  //   } catch (e) {
  //     // return left(Failure(e.toString()));
  //     print(e.toString());
  //   }
  // }

  Stream<List<Course>> getUserCommunities(String uid) {
    return _courses.where('author', isEqualTo: uid).snapshots().map((event) {
      List<Course> courses = [];
      for (var doc in event.docs) {
        courses.add(Course.fromMap(doc.data() as Map<String, dynamic>));
      }
      return courses;
    });
  }

  CollectionReference get _courses =>
      _firestore.collection(FirebaseConstants.coursesCollection);
  CollectionReference get _students =>
      _firestore.collection(FirebaseConstants.studentsCollection);
}
