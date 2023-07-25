import 'package:cloud_firestore/cloud_firestore.dart';

class ViewAttendanceRepository {
  final FirebaseFirestore _firestore;
  ViewAttendanceRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
}
