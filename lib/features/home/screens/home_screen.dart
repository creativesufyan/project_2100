import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/controllers/auth_controller.dart';
import 'my_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final teacher = ref.watch(teacherProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        // actions: [
        //   TextButton(onPressed: (){googleSi}, child: Text("Log out"))
        // ],
      ),
      drawer: MyDrawer(
        teacher: teacher,
        ref: ref,
      ),
    );
  }
}
