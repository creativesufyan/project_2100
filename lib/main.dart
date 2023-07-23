import 'package:attendance_app/core/common/loader.dart';
import 'package:attendance_app/features/auth/controllers/auth_controller.dart';

import 'package:attendance_app/models/teacher_model.dart';
import 'package:attendance_app/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import 'core/common/error_text.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  TeacherModel? teacherModel;

  void getData(WidgetRef ref, User data) async {
    teacherModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(teacherProvider.notifier).update((state) => teacherModel);
    setState(() {});
  }

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
                  if (data != null) {
                    getData(ref, data);
                    if (teacherModel != null) {
                      return loggedInRoute;
                    }
                  }
                  return loggedOutRoute;
                },
              ),
              routeInformationParser: const RoutemasterParser(),
            ),
        error: (error, stackTrace) => ErrorText(error: error.toString()),
        loading: () => const Loader());
  }
}
