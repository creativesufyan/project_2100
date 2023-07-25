import 'package:attendance_app/features/courses/controller/course_controller.dart';
import 'package:attendance_app/features/courses/repository/course_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/student_data.dart';

const List<String> sectionList = <String>['A', 'B', 'C'];
const List<String> seriesList = <String>['2021', '2022'];
const List<String> courseList = <String>[
  'CSE-1201',
  'CSE-1202',
  'CSE-1203',
  'CSE-1204',
  'PHY-1213',
  'Math-1213',
  'EEE-1251'
];

class AddCourseSheet extends ConsumerStatefulWidget {
  const AddCourseSheet({required this.context, super.key});
  final BuildContext context;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddCourseSheetState();
}

class _AddCourseSheetState extends ConsumerState<AddCourseSheet> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  String dropdownSectionValue = sectionList.first;
  String dropdownCourseValue = courseList.first;
  String dropdownSeriesValue = seriesList.first;

  void createCourse() async {
    ref.read(courseControllerProvider.notifier).createCourse(
        nameController.text.trim(),
        dropdownCourseValue,
        dropdownSeriesValue,
        dropdownSectionValue,
        context);
    // await ref.read(courseRepositoryProvider).createStudent(studentsList);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(courseControllerProvider);
    return DraggableScrollableSheet(
        initialChildSize: 0.7,
        builder: (_, controller) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Text(
                    "Create Course",
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: nameController,
                    // scrollPadding: EdgeInsets.only(bottom: 8.0),
                    keyboardType: TextInputType.name,
                    maxLength: 21,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                      hintText: 'Enter a name here',
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  DropdownButtonFormField<String>(
                    value: dropdownCourseValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    decoration: const InputDecoration(
                        labelText: "Course",
                        prefixIcon: Icon(Icons.arrow_drop_down_sharp),
                        border: OutlineInputBorder()),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownCourseValue = value!;
                      });
                    },
                    items: courseList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: dropdownSeriesValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          decoration: const InputDecoration(
                              labelText: "Series",
                              prefixIcon: Icon(Icons.arrow_drop_down_sharp),
                              border: OutlineInputBorder()),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownSeriesValue = value!;
                            });
                          },
                          items: seriesList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: dropdownSectionValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          decoration: const InputDecoration(
                              labelText: "Section",
                              prefixIcon: Icon(Icons.arrow_drop_down_sharp),
                              border: OutlineInputBorder()),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownSectionValue = value!;
                            });
                          },
                          items: sectionList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  ElevatedButton(
                      onPressed: isLoading ? null : createCourse,
                      child: isLoading
                          ? const Expanded(
                              child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ))
                          : const Text("Submit"))
                ],
              ),
            ),
          );
        });
  }
}
