import 'package:attendance_app/features/courses/controller/course_controller.dart';
import 'package:attendance_app/features/courses/screens/add_course_sheet.dart';
import 'package:attendance_app/features/home/course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../core/size_config.dart';
import '../../auth/controllers/auth_controller.dart';
import '../my_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _addCourseModalSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return AddCourseSheet(
          context: context,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    final teacher = ref.watch(teacherProvider)!;
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        backgroundColor: Theme.of(context).primaryColor.withAlpha(100),
      ),
      drawer: MyDrawer(
        teacher: teacher,
        ref: ref,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addCourseModalSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      body: ref.watch(teacherCourseProvider).when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return CourseCard(
                      name: data[index].name,
                      courseCode: data[index].courseName,
                      section: data[index].section,
                      series: data[index].series);
                },
              );
            },
            error: (error, stackTrace) {
              return ErrorText(error: error.toString());
            },
            loading: () => const Loader(),
          ),
    );
  }
}
