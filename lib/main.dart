import 'package:attendance_app/core/common/loader.dart';
import 'package:attendance_app/features/auth/controllers/auth_controller.dart';
import 'package:attendance_app/features/auth/screens/login_screen.dart';
import 'package:attendance_app/models/user_model.dart';
import 'package:attendance_app/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import 'core/common/error_text.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
        data: (data) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Attendance App',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              routerDelegate: RoutemasterDelegate(
                routesBuilder: (context) {
                  if (data) {
                    return loggedInRoute;
                  } else {
                    return loggedOutRoute;
                  }
                },
              ),
              routeInformationParser: const RoutemasterParser(),
            ),
        error: (error, stackTrace) => ErrorText(error: error.toString()),
        loading: () => const Loader());
  }
}
