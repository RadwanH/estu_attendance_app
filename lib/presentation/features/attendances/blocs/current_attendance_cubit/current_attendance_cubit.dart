import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:course_repository/course_repository.dart';
import 'package:equatable/equatable.dart';

part 'current_attendance_state.dart';

class CurrentAttendanceCubit extends Cubit<CurrentAttendanceState> {
  CurrentAttendanceCubit() : super(CurrentAttendanceInitial());

  void startAttendanceSession(Attendance attendance) {
    final generatedCode = _generateRandomCode();
    emit(CurrentAttendanceInProgress(
        attendance, generatedCode, attendance.timer));
    _startTimer(attendance.timer);
  }

  void _startTimer(int initialTimerDuration) {
    int remainingTime = initialTimerDuration;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
        // Check if the current state is CurrentAttendanceInProgress before casting
        if (state is CurrentAttendanceInProgress) {
          emit(
            CurrentAttendanceInProgress(
              (state as CurrentAttendanceInProgress).attendance,
              (state as CurrentAttendanceInProgress).generatedCode,
              remainingTime,
            ),
          );
        } else {
          timer
              .cancel(); // Stop the timer if the state is no longer CurrentAttendanceInProgress
        }
      } else {
        timer.cancel();
        if (state is CurrentAttendanceInProgress) {
          emit(CurrentAttendanceSessionEnded(
            (state as CurrentAttendanceInProgress).attendance,
          ));
        }
      }
    });
  }

  String _generateRandomCode() {
    const length = 6;
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ));
  }

  void submitCode(String code, String studentId) {
    if (state is CurrentAttendanceInProgress) {
      final currentState = state as CurrentAttendanceInProgress;
      if (code == currentState.generatedCode &&
          currentState.remainingTime > 0) {
        final updatedAttendees =
            List<String>.from(currentState.attendance.attendeesIds ?? []);
        updatedAttendees.add(studentId);
        final updatedAttendance =
            currentState.attendance.copyWith(attendeesIds: updatedAttendees);
        emit(CurrentAttendanceInProgress(updatedAttendance,
            currentState.generatedCode, currentState.remainingTime));
        emit(CurrentAttendanceSuccess(
            updatedAttendance, "Attendance recorded for $studentId!"));
      } else {
        emit(CurrentAttendanceFailure("Incorrect code or session expired!"));
      }
    }
  }
}
