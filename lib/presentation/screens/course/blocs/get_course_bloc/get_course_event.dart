part of 'get_course_bloc.dart';

sealed class GetCourseEvent extends Equatable {
  const GetCourseEvent();

  @override
  List<Object> get props => [];
}

class GetCourse extends GetCourseEvent {}
