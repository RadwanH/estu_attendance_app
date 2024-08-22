import 'package:course_repository/course_repository.dart';
import 'package:estu_attendance_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:estu_attendance_app/presentation/features/attendances/blocs/current_attendance_cubit/current_attendance_cubit.dart';
import 'package:estu_attendance_app/presentation/features/attendances/views/active_attendance_screen.dart';
import 'package:estu_attendance_app/presentation/features/attendances/views/attendances_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../components/my_round_button.dart';
import '../../../../constants/app_colors.dart';
import '../blocs/active_attendances_cubit/active_attendances_cubit.dart';

class ActiveAttendance extends StatelessWidget {
  final List<Course> courses;
  const ActiveAttendance({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActiveAttendancesCubit, ActiveAttendancesState>(
      listener: (context, state) {
        if (state is ActiveAttendancesCodeSubmissionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Attendance submitted successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is ActiveAttendancesFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Failed to load active attendances: ${state.error}'),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ActiveAttendancesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ActiveAttendancesSuccess) {
          if (state.activeAttendances.isEmpty) {
            return const Center(
              child: Text('No Active Attendances Yet'),
            );
          }
          return ActiveAttendanceGrid(
            attendances: state.activeAttendances,
            courses: courses,
          );
        } else if (state is ActiveAttendancesFailure) {
          return Center(
              child: Text('Failed to load active attendances: ${state.error}'));
        }
        return Container();
      },
    );
  }
}

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

// class AttendanceCodeDialog extends StatelessWidget {
//   final void Function(String) onSubmit;

//   AttendanceCodeDialog({required this.onSubmit});

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController controller = TextEditingController();

//     return AlertDialog(
//       title: const Text("Enter Code"),
//       content: TextField(
//         controller: controller,
//         decoration:
//             const InputDecoration(hintText: "Enter the attendance code"),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             onSubmit(controller.text);
//             Navigator.of(context).pop();
//           },
//           child: const Text("Submit"),
//         ),
//       ],
//     );
//   }
// }

// dialog with validation

class AttendanceCodeDialog extends StatefulWidget {
  final void Function(String) onSubmit;
  final String correctCode; // Add a correct code to compare with

  AttendanceCodeDialog({
    required this.onSubmit,
    required this.correctCode,
  });

  @override
  _AttendanceCodeDialogState createState() => _AttendanceCodeDialogState();
}

class _AttendanceCodeDialogState extends State<AttendanceCodeDialog> {
  final TextEditingController controller = TextEditingController();
  String? errorText;

  void _validateAndSubmit() {
    final inputCode = controller.text;
    if (inputCode == widget.correctCode) {
      widget.onSubmit(inputCode);
      Navigator.of(context).pop();
    } else {
      setState(() {
        errorText = "Incorrect code, please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Enter Code"),
      content: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        inputFormatters: [
          UpperCaseTextFormatter(), // Custom formatter to capitalize input
        ],
        decoration: InputDecoration(
          hintText: "Enter the attendance code",
          errorText: errorText, // Display error message if validation fails
        ),
      ),
      actions: [
        TextButton(
          onPressed: _validateAndSubmit, // Validate on submit
          child: const Text("Submit"),
        ),
      ],
    );
  }
}

// Custom formatter to automatically capitalize the input
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
