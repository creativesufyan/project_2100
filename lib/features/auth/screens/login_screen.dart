import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/auth_controller.dart';

void signInWithGoogle(BuildContext context, WidgetRef ref) {
  ref.read(authControllerProvider).authenticate(context);
}

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Attendance App",
            style: TextStyle(fontSize: 32.0),
          ),
          ElevatedButton.icon(
              onPressed: () => signInWithGoogle(context, ref),
              icon: const Icon(Icons.lunch_dining_rounded),
              label: const Text("Login using google"))
        ],
      ),
    );
  }
}
