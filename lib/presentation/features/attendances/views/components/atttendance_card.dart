import 'package:course_repository/course_repository.dart';
import 'package:estu_attendance_app/components/my_macro_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceCard extends StatelessWidget {
  final Attendance attendance;
  final Color? color;

  const AttendanceCard({super.key, required this.attendance, this.color});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy');
    final timeFormat = DateFormat('hh:mm a');
    final formattedDate = attendance.date != null
        ? dateFormat.format(attendance.date!)
        : 'No date';

    final formattedTime = attendance.date != null
        ? timeFormat.format(attendance.date!)
        : 'No time';

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Colors.black12,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: color != null
                ? [
                    color!.withOpacity(0.7),
                    color!.withOpacity(0.3),
                  ]
                : [
                    Colors.blue.shade100,
                    Colors.blue.shade50,
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  formattedTime,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue.shade600,
                  ),
                ),
              ],
            ),
            const Divider(height: 30, thickness: 1),
            Wrap(
              children: [
                MyMacroCard(
                  backgroundColor: Colors.blueAccent,
                  icon: Icons.calendar_today,
                  text: ': ${attendance.week}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                MyMacroCard(
                  backgroundColor: Colors.redAccent,
                  icon: Icons.timer,
                  text: ': ${attendance.timer}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Lessons: ${attendance.forHours.join(', ')}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
