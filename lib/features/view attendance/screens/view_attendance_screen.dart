import 'package:attendance_app/features/view%20attendance/controller/view_attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../models/course_attendance_model.dart';
import '../../../models/student_model.dart';
import 'filter_chip_data.dart';
import 'filter_chips.dart';

final studentListProvider =
    StateProvider.family<List<Student>, String>((ref, section) {
  return ref.watch(getStudentListProvider(section)).asData!.value;
});

class ViewAttendanceScreen extends ConsumerStatefulWidget {
  const ViewAttendanceScreen(
      {super.key, required this.section, required this.name});
  final String section;
  final String name;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends ConsumerState<ViewAttendanceScreen> {
  List<FilterChipData> filterChips = FilterChips.all;
  // List<Student> studentList = [];
  late CourseAttendanceModel attendanceList;
  List<Student> filterStudents = [];
  bool isFirst = true;
  // final sub = stream.listen()

  Widget buildChips() => Wrap(
        runSpacing: 8.0,
        spacing: 8,
        children: filterChips
            .map((filterChip) => FilterChip(
                selected: filterChip.isSelected,
                label: Text(filterChip.label),
                onSelected: (isSelected) {
                  setState(() {
                    filterChips = filterChips.map((otherChip) {
                      final newChip = otherChip.copyWith(isSelected: false);
                      if (filterChip == newChip) {
                        if (newChip.label == "All") {
                          filterStudents =
                              ref.read(studentListProvider(widget.section));
                          // print(filterStudents);
                        }
                        if (newChip.label == "Present") {
                          filterStudents = ref
                              .read(studentListProvider(widget.section))
                              .where((element) {
                            return attendanceList.present
                                .contains(element.roll);
                          }).toList();
                        }
                        if (newChip.label == "Absent") {
                          filterStudents = ref
                              .read(studentListProvider(widget.section))
                              .where((element) {
                            return attendanceList.absent.contains(element.roll);
                          }).toList();
                        }
                        if (newChip.label == "Late") {
                          filterStudents = ref
                              .read(studentListProvider(widget.section))
                              .where((element) {
                            return attendanceList.late.contains(element.roll);
                          }).toList();
                        }
                        return newChip.copyWith(isSelected: isSelected);
                      } else {
                        return newChip;
                      }
                    }).toList();
                  });
                }))
            .toList(),
      );
  void getStudent() {
    ref.watch(getStudentListProvider(widget.section)).when(
        data: (data) {
          // print(data);
        },
        error: (error, stackTrace) {
          return ErrorText(error: error.toString());
        },
        loading: () => const Loader());
  }

  @override
  Widget build(BuildContext context) {
    getStudent();
    // final type =
    //     filterChips.indexWhere((element) => element.isSelected == true);
    // print(type);

    // if (type == 1) {

    //   print(filterStudents);
    // }
    return Scaffold(
        appBar: AppBar(
          title: const Text("View Attendance"),
        ),
        body: ref.watch(getAttendanceListProvider(widget.name)).when(
              data: (data) {
                if (data.isEmpty) {
                  return const ErrorText(
                      error: "No attendance for this course is available");
                }
                attendanceList = data[0];

                // ref.read(studentListProvider.notifier).update((state) => data);
                if (isFirst) {
                  filterStudents =
                      ref.read(studentListProvider(widget.section));
                  isFirst = false;
                }

                //   print(filterStudents);

                // print("data: $data");

                return Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: buildChips(),
                    ),
                    Expanded(
                      flex: 9,
                      child: SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: filterStudents.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(filterStudents[index].name),
                              trailing: Text(filterStudents[index].roll),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
              error: (error, stackTrace) {
                return ErrorText(error: error.toString());
              },
              loading: () => const Loader(),
            ));
  }
}
