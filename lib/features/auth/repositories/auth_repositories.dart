import 'package:attendance_app/core/typedefs.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/constants/constants.dart';
import '../../../core/failure.dart';
import '../../../core/providers/sign_in_provider.dart';
import '../../../models/user_model.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    googleSignIn: ref.read(googleSignInProvider),
  ),
);

class AuthRepository {
  final GoogleSignIn _googleSignIn;

  AuthRepository({required googleSignIn}) : _googleSignIn = googleSignIn;

  Future<bool> get authStateChange => _googleSignIn.isSignedIn();

  FutureEither<UserModel> signInUsingGoogle() async {
    try {
      final user = await _googleSignIn.signIn();

      UserModel userModel = UserModel(
          name: user!.displayName ?? "No Name",
          email: user.email,
          photoUrl: user.photoUrl ?? Constants.avatarDefault);

      // print(userModel);

      return right(userModel);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  UserModel createModel() {
    final user = _googleSignIn.currentUser;
    UserModel userModel = UserModel(
        name: user!.displayName ?? "No Name",
        email: user.email,
        photoUrl: user.photoUrl ?? Constants.avatarDefault);
    return userModel;
  }

  void logOut() async {
    await _googleSignIn.signOut();
  }
}
