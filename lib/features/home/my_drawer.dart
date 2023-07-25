import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/teacher_model.dart';
import '../auth/controllers/auth_controller.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, required this.teacher, required this.ref});
  final WidgetRef ref;

  final TeacherModel teacher;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(teacher.photoUrl),
                        ),
                      ),
                      Text(
                        teacher.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        teacher.email,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: ListView(
                  children: [
                    ListTile(
                      title: const Text("Log Out"),
                      leading: const Icon(Icons.logout),
                      onTap: () =>
                          ref.read(authControllerProvider.notifier).logout(),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
