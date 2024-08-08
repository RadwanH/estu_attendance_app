part of 'get_course_bloc.dart';

sealed class GetCourseState extends Equatable {
  const GetCourseState();

  @override
  List<Object> get props => [];
}

final class GetCourseInitial extends GetCourseState {}

final class GetCourseLoading extends GetCourseState {}

final class GetCourseFailure extends GetCourseState {
  final String error;

  const GetCourseFailure(this.error);

  @override
  List<Object> get props => [error];
}

final class GetCourseSuccess extends GetCourseState {
  final List<Course> courses;

  const GetCourseSuccess(this.courses);

  @override
  List<Object> get props => [courses];
}
