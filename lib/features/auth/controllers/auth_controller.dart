import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils.dart';
import '../../../models/teacher_model.dart';
import '../repositories/auth_repositories.dart';

// final userProvider = StateProvider<UserModel?>((ref) => null);
final teacherProvider = StateProvider<TeacherModel?>((ref) {
  return null;
});

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
      authRepository: ref.read(authRepositoryProvider), ref: ref),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void authenticate(BuildContext context) async {
    final user = await _authRepository.signInUsingGoogle();
    user.fold(
        (l) => showSnackBar(context, l.message),
        (teacherModel) => _ref
            .read(teacherProvider.notifier)
            .update((state) => teacherModel));
  }

  Stream<TeacherModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void logout() async {
    _authRepository.logOut();
  }
}
