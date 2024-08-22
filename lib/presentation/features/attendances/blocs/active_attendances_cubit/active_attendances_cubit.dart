import 'package:bloc/bloc.dart';
import 'package:course_repository/course_repository.dart';
import 'package:equatable/equatable.dart';

part 'active_attendances_state.dart';

class ActiveAttendancesCubit extends Cubit<ActiveAttendancesState> {
  final AttendanceRepo attendanceRepo;
  ActiveAttendancesCubit(this.attendanceRepo)
      : super(ActiveAttendancesInitial());

  Future<void> getActiveAttendances(List<String> coursesIds) async {
    emit(ActiveAttendancesLoading());
    try {
      List<Attendance> allActiveAttendances = [];

      for (String courseId in coursesIds) {
        final attendances = await attendanceRepo.getCourseAttendances(courseId);
        final activeAttendances =
            attendances.where((attendance) => attendance.isActive).toList();
        allActiveAttendances.addAll(activeAttendances);
      }

      emit(ActiveAttendancesSuccess(activeAttendances: allActiveAttendances));
    } catch (e) {
      emit(ActiveAttendancesFailure(error: e.toString()));
    }
  }

  void submitAttendanceCode(
      String code, Attendance attendance, String studentId) async {
    if (attendance.generatedCode == code) {
      try {
        // Add the student's ID to the attendance's attendeesIds list
        attendance.attendeesIds!.add(studentId);

        // Update the attendance record in the repository
        await attendanceRepo.updateAttendance(attendance);

        // Re-fetch active attendances to update the UI
        await getActiveAttendances([attendance.courseId]);

        emit(ActiveAttendancesCodeSubmissionSuccess(attendance: attendance));
      } catch (e) {
        emit(ActiveAttendancesFailure(
            error: 'Failed to submit attendance code: $e'));
      }
    } else {
      emit(ActiveAttendancesFailure(error: 'Invalid attendance code.'));
    }
  }
}
