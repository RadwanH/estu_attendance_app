// import 'package:course_repository/course_repository.dart';
// import 'package:estu_attendance_app/presentation/features/attendances/blocs/current_attendance_cubit/current_attendance_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ActiveAttendanceScreen extends StatelessWidget {
//   final Attendance attendance;

//   ActiveAttendanceScreen({required this.attendance});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Attendance Session")),
//       body: BlocBuilder<CurrentAttendanceCubit, CurrentAttendanceState>(
//         builder: (context, state) {
//           if (state is CurrentAttendanceActive) {
//             return Column(
//               children: [
//                 Text("Course: ${attendance.courseId}"),
//                 Text("Week: ${attendance.week}"),
//                 CountdownTimer(duration: state.attendance.timer),
//                 ElevatedButton(
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) => AttendanceCodeDialog(
//                         onSubmit: (code) {
//                           context
//                               .read<CurrentAttendanceCubit>()
//                               .submitCode(code, "studentId", attendance);
//                         },
//                       ),
//                     );
//                   },
//                   child: Text("Attend"),
//                 ),
//               ],
//             );
//           } else if (state is CurrentAttendanceCountingDown) {
//             return Column(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) => AttendanceCodeDialog(
//                         onSubmit: (code) {
//                           context
//                               .read<CurrentAttendanceCubit>()
//                               .submitCode(code, "studentId", attendance);
//                         },
//                       ),
//                     );
//                   },
//                   child: Text("Attend"),
//                 ),
//                 Text("Time Left: ${state.duration} seconds"),
//               ],
//             );
//           } else if (state is CurrentAttendanceExpired) {
//             return Text("CurrentAttendance session has expired");
//           } else if (state is CurrentAttendanceError) {
//             return Text("Incorrect Code");
//           }
//           return Container(
//             child: Text("The state is :  ${state}"),
//           );
//         },
//       ),
//     );
//   }
// }

// class CountdownTimer extends StatelessWidget {
//   final int duration;

//   CountdownTimer({required this.duration});

//   @override
//   Widget build(BuildContext context) {
//     return Text("Time Left: $duration seconds");
//   }
// }

// class AttendanceCodeDialog extends StatelessWidget {
//   final void Function(String) onSubmit;

//   AttendanceCodeDialog({required this.onSubmit});

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController controller = TextEditingController();

//     return AlertDialog(
//       title: Text("Enter Code"),
//       content: TextField(
//         controller: controller,
//         decoration: InputDecoration(hintText: "Enter the attendance code"),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             onSubmit(controller.text);
//             Navigator.of(context).pop();
//           },
//           child: Text("Submit"),
//         ),
//       ],
//     );
//   }
// }
