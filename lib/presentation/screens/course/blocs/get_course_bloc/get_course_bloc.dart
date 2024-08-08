import 'package:bloc/bloc.dart';
import 'package:course_repository/course_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_course_event.dart';
part 'get_course_state.dart';

class GetCourseBloc extends Bloc<GetCourseEvent, GetCourseState> {
  final CourseRepo _courseRepo;

  GetCourseBloc(this._courseRepo) : super(GetCourseInitial()) {
    on<GetCourse>((event, emit) async {
      emit(GetCourseLoading());
      try {
        List<Course> courses = await _courseRepo.getCourses();
        emit(GetCourseSuccess(courses));
      } catch (e) {
        emit(GetCourseFailure(e.toString()));
      }
    });
  }
}
