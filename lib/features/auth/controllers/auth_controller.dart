import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils.dart';
import '../../../models/user_model.dart';
import '../repositories/auth_repositories.dart';

// final userProvider = StateProvider<UserModel?>((ref) => null);
final userProvider = StateNotifierProvider<AuthController, UserModel?>((ref) {
  return ref.watch(authControllerProvider);
});

final authControllerProvider = Provider(
  (ref) => AuthController(
      authRepository: ref.read(authRepositoryProvider), ref: ref),
);

final authStateChangeProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.authStateChange;
});

class AuthController extends StateNotifier<UserModel?> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(null);

  Future<bool> get authStateChange => _authRepository.authStateChange;

  void authenticate(BuildContext context) async {
    final user = await _authRepository.signInUsingGoogle();
    user.fold((l) => showSnackBar(context, l.message), (r) {
      state = r;
    });
  }

  void logout() async {
    _authRepository.logOut();
  }
}
