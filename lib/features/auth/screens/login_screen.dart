import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/auth_controller.dart';

void signInWithGoogle(BuildContext context, WidgetRef ref) {
  ref.read(authControllerProvider.notifier).authenticate(context);
}

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Attendance App",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32.0),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
                onPressed: () => signInWithGoogle(context, ref),
                child: const Text("Login using google"))
          ],
        ),
      ),
    );
  }
}
