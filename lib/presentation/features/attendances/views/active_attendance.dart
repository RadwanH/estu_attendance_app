import 'package:course_repository/course_repository.dart';
import 'package:estu_attendance_app/presentation/features/attendances/blocs/current_attendance_cubit/current_attendance_cubit.dart';
import 'package:estu_attendance_app/presentation/features/attendances/views/active_attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/my_round_button.dart';
import '../../../../constants/app_colors.dart';

class ActiveAttendance extends StatelessWidget {
  const ActiveAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    final currentAttendanceCubit = context.read<CurrentAttendanceCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 20, color: AppColors.kGreyColor.withOpacity(0.7)),
          ],
        ),
        child: BlocConsumer<CurrentAttendanceCubit, CurrentAttendanceState>(
          listener: (context, state) {
            if (state is CurrentAttendanceSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is CurrentAttendanceFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is CurrentAttendanceInProgress) {
              print(state.generatedCode);
              print(' Remaining time: ${state.remainingTime}');
              print(' attendance timer: ${state.attendance.timer}');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Course: ${state.attendance.courseId}",
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text("Week: ${state.attendance.week}",
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text("Time Left: ${state.remainingTime} seconds",
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  MyRoundButton(
                    onTap: state.remainingTime > 0
                        ? () => showDialog(
                              context: context,
                              builder: (context) => AttendanceCodeDialog(
                                onSubmit: (code) {
                                  // Use the cubit instance directly
                                  currentAttendanceCubit.submitCode(
                                      code, "student1");
                                },
                              ),
                            )
                        : () {},
                    title: "Attend",
                  ),
                  const SizedBox(height: 16),
                  if (state.attendance.attendeesIds != null &&
                      state.attendance.attendeesIds!.isNotEmpty)
                    const Text("Attendees:", style: TextStyle(fontSize: 18)),
                  ...?state.attendance.attendeesIds
                      ?.map((id) => Text(id))
                      .toList(),
                ],
              );
            } else if (state is CurrentAttendanceSessionEnded) {
              print(state);
              return const Center(child: Text("The Attendance Has Expired."));
            } else if (state is CurrentAttendanceSuccess) {
              // Future.delayed(const Duration(seconds: 30), () {
              //   return Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         children: [
              //           Text("Course: ${state.attendance.courseId}",
              //               style: const TextStyle(fontSize: 16)),
              //           const SizedBox(width: 8),
              //           Text("Week: ${state.attendance.week}",
              //               style: const TextStyle(fontSize: 16)),
              //         ],
              //       ),
              //       const SizedBox(height: 8),
              //       Text(
              //         textAlign: TextAlign.center,
              //         "You have registered your attendance successfully",
              //         style: TextStyle(
              //           fontSize: 18,
              //           color: Colors.green.withOpacity(0.9),
              //           fontWeight: FontWeight.w900,
              //         ),
              //       ),
              //       const SizedBox(height: 8),
              //     ],
              //   );
              // });

              return Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "No Attendances Opened At The Moment",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.withOpacity(0.9),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class AttendanceCodeDialog extends StatelessWidget {
  final void Function(String) onSubmit;

  AttendanceCodeDialog({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return AlertDialog(
      title: const Text("Enter Code"),
      content: TextField(
        controller: controller,
        decoration:
            const InputDecoration(hintText: "Enter the attendance code"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            onSubmit(controller.text);
            Navigator.of(context).pop();
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
