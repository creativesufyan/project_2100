import 'package:attendance_app/features/take%20attendance/screens/take_attendance_screen.dart';
import 'package:flutter/material.dart';

import '../../core/size_config.dart';
import '../view attendance/screens/view_attendance_screen.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.name,
    required this.courseCode,
    required this.section,
    required this.series,
  });

  final String name;
  final String courseCode;
  final String section;
  final String series;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
      height: getProportionateScreenHeight(354),
      width: getProportionateScreenWidth(354),
      decoration: ShapeDecoration(
        color: Colors.deepPurple[100],
        // gradient: const RadialGradient(
        //   center: Alignment(0, 1),
        //   radius: 0,
        //   colors: [Colors.white, Color(0xFFF8F9FF)],
        // ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.50, color: Color(0x4C56ADFE)),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenHeight(24)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: const Color(0xFF24363C),
                      fontSize: getProportionateScreenWidth(8),
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Name\n\n',
                      ),
                      TextSpan(
                        text: name,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(14),
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: const Color(0xFF24363C),
                      fontSize: getProportionateScreenWidth(8),
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Section\n\n',
                      ),
                      TextSpan(
                        text: section,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: const Color(0xFF24363C),
                  fontSize: getProportionateScreenWidth(8),
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  const TextSpan(
                    text: 'Course Code\n\n',
                  ),
                  TextSpan(
                    text: courseCode,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: const Color(0xFF24363C),
                      fontSize: getProportionateScreenWidth(8),
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Series\n\n',
                      ),
                      TextSpan(
                        text: series,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(14),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => TakeAttendanceScreen(
                                        section: section,
                                        name: name,
                                      )));
                        },
                        child: const Text("Take Attendance")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => ViewAttendanceScreen(
                                        section: section,
                                        name: name,
                                      )));
                        },
                        child: const Text("View Attendance")),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
