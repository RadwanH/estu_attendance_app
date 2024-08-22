part of 'active_attendances_cubit.dart';

sealed class ActiveAttendancesState extends Equatable {
  const ActiveAttendancesState();

  @override
  List<Object> get props => [];
}

final class ActiveAttendancesInitial extends ActiveAttendancesState {}

class ActiveAttendancesLoading extends ActiveAttendancesState {}

class ActiveAttendancesSuccess extends ActiveAttendancesState {
  final List<Attendance> activeAttendances;

  const ActiveAttendancesSuccess({required this.activeAttendances});

  @override
  List<Object> get props => [activeAttendances];
}

class ActiveAttendancesFailure extends ActiveAttendancesState {
  final String error;

  const ActiveAttendancesFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class ActiveAttendancesCodeSubmissionSuccess extends ActiveAttendancesState {
  final Attendance attendance;

  const ActiveAttendancesCodeSubmissionSuccess({required this.attendance});

  @override
  List<Object> get props => [attendance];
}
