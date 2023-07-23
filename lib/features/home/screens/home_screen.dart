import 'package:attendance_app/features/auth/controllers/auth_controller.dart';
import 'package:attendance_app/features/auth/repositories/auth_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userModel = ref.watch(userProvider);
    final user = ref.watch(authRepositoryProvider).createModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        // actions: [
        //   TextButton(onPressed: (){googleSi}, child: Text("Log out"))
        // ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage((userModel == null)
                              ? user.photoUrl
                              : userModel.photoUrl),
                        ),
                      ),
                      Text(
                        (userModel == null) ? user.name : userModel.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        (userModel == null) ? user.email : userModel.email,
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
                      onTap: () => ref.read(authControllerProvider).logout(),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
