import 'package:course_repository/course_repository.dart';
import '../active_attendance.dart';
import 'package:flutter/material.dart';

import 'active_attendance_card.dart';

class ActiveAttendanceGrid extends StatelessWidget {
  final List<Course> courses;
  final List<Attendance> attendances;
  const ActiveAttendanceGrid(
      {super.key, required this.attendances, required this.courses});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: attendances.isNotEmpty
          ? Wrap(
              spacing: 8,
              runSpacing: 14,
              children: attendances.map((attendance) {
                final course = courses.firstWhere(
                    (course) => course.courseId == attendance.courseId);
                return ActiveAttendanceCard(
                  attendance: attendance,
                  course: course,
                );
              }).toList(),
            )
          : const Center(
              child: Text('No Attendances found...'),
            ),
    );
  }
}
