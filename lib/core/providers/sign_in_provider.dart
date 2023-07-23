import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);
final authProvider = Provider((ref) => FirebaseAuth.instance);
final storageProvider = Provider((ref) => FirebaseStorage.instance);

final googleSignInProvider = Provider((ref) => GoogleSignIn(
    // scopes: [
    //   "https://www.googleapis.com/auth/drive",
    //   "https://www.googleapis.com/auth/spreadsheets"
    // ],
    ));
