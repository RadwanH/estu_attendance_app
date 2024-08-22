import 'package:course_repository/course_repository.dart';
import '../../../../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../../../../components/my_round_button.dart';
import '../../../../../constants/app_colors.dart';
import '../../blocs/active_attendances_cubit/active_attendances_cubit.dart';
import '../active_attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ActiveAttendanceCard extends StatelessWidget {
  final Course course;
  final Attendance attendance;
  const ActiveAttendanceCard(
      {super.key, required this.attendance, required this.course});

  @override
  Widget build(BuildContext context) {
    final activeAttendanceCubit = context.read<ActiveAttendancesCubit>();
    final currentStudentId =
        context.read<AuthenticationBloc>().state.user!.userId;

    final dateFormat = DateFormat('dd-MM-yyyy');
    final timeFormat = DateFormat('hh:mm a');
    final formattedDate = attendance.date != null
        ? dateFormat.format(attendance.date!)
        : 'No date';

    final formattedTime = attendance.date != null
        ? timeFormat.format(attendance.date!)
        : 'No time';
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: attendance.attendeesIds!.contains(currentStudentId)
              ? Colors.greenAccent.shade100
              : Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 20, color: AppColors.kGreyColor.withOpacity(0.7)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  course.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                attendance.attendeesIds!.contains(currentStudentId)
                    ? const Icon(
                        FontAwesomeIcons.check,
                        color: Colors.green,
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              formattedDate,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Color(0xFF1C1C1C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              formattedTime,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1C1C1C),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Week: ${attendance.week}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Timer: ${attendance.timer}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            !attendance.attendeesIds!.contains(currentStudentId)
                ? MyRoundButton(
                    onTap: attendance.isActive
                        ? () => showDialog(
                              context: context,
                              builder: (context) => AttendanceCodeDialog(
                                onSubmit: (code) {
                                  activeAttendanceCubit.submitAttendanceCode(
                                      code, attendance, currentStudentId);
                                },
                                correctCode: attendance.generatedCode,
                              ),
                            )
                        : () {},
                    title: "Attend",
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
