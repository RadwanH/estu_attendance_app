import 'package:course_repository/course_repository.dart';
import '../../../../blocs/authentication_bloc/authentication_bloc.dart';
import '../blocs/current_attendance_cubit/current_attendance_cubit.dart';
import 'active_attendance_screen.dart';
import 'attendances_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../components/my_round_button.dart';
import '../../../../constants/app_colors.dart';
import '../blocs/active_attendances_cubit/active_attendances_cubit.dart';
import 'components/active_attendance_grid.dart';

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
