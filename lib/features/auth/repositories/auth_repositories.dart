import 'package:attendance_app/core/typedefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../core/failure.dart';
import '../../../core/providers/sign_in_provider.dart';
import '../../../models/teacher_model.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    googleSignIn: ref.read(googleSignInProvider),
    firebaseAuth: ref.read(authProvider),
    firestore: ref.read(firestoreProvider),
  ),
);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AuthRepository(
      {required GoogleSignIn googleSignIn,
      required FirebaseFirestore firestore,
      required FirebaseAuth firebaseAuth})
      : _googleSignIn = googleSignIn,
        _firestore = firestore,
        _auth = firebaseAuth;

  CollectionReference get _teachers =>
      _firestore.collection(FirebaseConstants.teachersCollection);
  Stream<User?> get authStateChange => _auth.authStateChanges();

  FutureEither<TeacherModel> signInUsingGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      TeacherModel teacherModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        teacherModel = TeacherModel(
            name: userCredential.user!.displayName ?? "No Name",
            email: userCredential.user!.email ?? '',
            photoUrl: userCredential.user!.photoURL ?? Constants.avatarDefault,
            uid: userCredential.user!.uid);
        await _teachers.doc(userCredential.user!.uid).set(teacherModel.toMap());
      } else {
        teacherModel = await getUserData(userCredential.user!.uid).first;
      }

      return right(teacherModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<TeacherModel> getUserData(String uid) {
    return _teachers.doc(uid).snapshots().map(
        (event) => TeacherModel.fromMap(event.data() as Map<String, dynamic>));
  }

  void logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
