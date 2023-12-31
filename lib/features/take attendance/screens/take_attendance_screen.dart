import 'package:attendance_app/features/take%20attendance/controller/take_attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';

enum Attendance { present, absent, late }

final dateTimeProvider = StateProvider<String>((ref) {
  var formatter = DateFormat('yyyy-MM-dd').format(DateTime.now());
  return formatter;
});

class TakeAttendanceScreen extends ConsumerStatefulWidget {
  const TakeAttendanceScreen(
      {super.key, required this.section, required this.name});
  final String section;
  final String name;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends ConsumerState<TakeAttendanceScreen> {
  void showDateTimePicker(BuildContext context, WidgetRef ref) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2017, 4, 1),
            lastDate: DateTime(2030, 4, 30))
        .then((value) => ref.read(dateTimeProvider.notifier).state =
            DateFormat('yyyy-MM-dd').format(value ?? DateTime.now()));
  }

  List<Attendance> presentAttendance =
      List.generate(60, (index) => Attendance.present);

  Set<String> present = {};
  Set<String> absent = {};
  Set<String> late = {};
  bool didRun = false;
  @override
  Widget build(BuildContext context) {
    // final isLoading = ref.watch(takeAttendanceControllerProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Take Attendance"),
          actions: [
            ElevatedButton(
                onPressed: () {
                  showDateTimePicker(context, ref);
                },
                child: Text(ref.watch(dateTimeProvider)))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => ref
              .read(takeAttendanceControllerProvider.notifier)
              .takeAttendance(present, absent, late, ref.read(dateTimeProvider),
                  widget.name, context),
          child: const Icon(Icons.add),
        ),
        body: ref.watch(getStudentListProvider(widget.section)).when(
              data: (data) {
                if (!didRun) {
                  for (var student in data) {
                    present.add(student.roll);
                  }
                  didRun = true;
                }
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            // minVerticalPadding: 8.0,
                            title: Text(data[index].name),
                            subtitle: Text(data[index].roll),
                          ),
                          SegmentedButton<Attendance>(
                            segments: const <ButtonSegment<Attendance>>[
                              ButtonSegment<Attendance>(
                                  value: Attendance.present,
                                  label: Text('Present'),
                                  icon: Icon(Icons.present_to_all)),
                              ButtonSegment<Attendance>(
                                  value: Attendance.absent,
                                  label: Text('Absent'),
                                  icon: Icon(Icons.calendar_view_week)),
                              ButtonSegment<Attendance>(
                                  value: Attendance.late,
                                  label: Text('Late'),
                                  icon: Icon(Icons.calendar_view_month)),
                            ],
                            selected: <Attendance>{presentAttendance[index]},
                            onSelectionChanged: (Set<Attendance> newSelection) {
                              setState(() {
                                // By default there is only a single segment that can be
                                // selected at one time, so its value is always the first
                                // item in the selected set.
                                presentAttendance[index] = newSelection.first;
                              });
                              if (presentAttendance[index] ==
                                  Attendance.present) {
                                present.add(data[index].roll);

                                late.remove(data[index].roll);

                                absent.remove(data[index].roll);
                              }
                              if (presentAttendance[index] == Attendance.late) {
                                late.add(data[index].roll);
                                present.add(data[index].roll);

                                absent.remove(data[index].roll);
                              }
                              if (presentAttendance[index] ==
                                  Attendance.absent) {
                                present.remove(data[index].roll);

                                late.remove(data[index].roll);

                                absent.add(data[index].roll);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 16.0,
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              error: (error, stackTrace) {
                return ErrorText(error: error.toString());
              },
              loading: () => const Loader(),
            ));
  }
}
