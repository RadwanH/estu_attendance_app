part of 'get_my_courses_cubit.dart';

sealed class GetMyCoursesState extends Equatable {
  const GetMyCoursesState();

  @override
  List<Object> get props => [];
}

final class GetMyCoursesInitial extends GetMyCoursesState {}
final class GetMyCoursesLoading extends GetMyCoursesState {}

final class GetMyCoursesSuccess extends GetMyCoursesState {
  final List<Course> courses;

  const GetMyCoursesSuccess(this.courses);

  @override
  List<Object> get props => [courses];
}

final class GetMyCoursesFailure extends GetMyCoursesState {
  final String message;

  const GetMyCoursesFailure(this.message);

  @override
  List<Object> get props => [message];
}