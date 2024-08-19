import 'package:bloc/bloc.dart';
import 'package:course_repository/course_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_my_courses_state.dart';

class GetMyCoursesCubit extends Cubit<GetMyCoursesState> {
  final CourseRepo _courseRepo;
  GetMyCoursesCubit(this._courseRepo) : super(GetMyCoursesInitial());

  Future<void> getMyCourses(String userId) async {
    emit(GetMyCoursesLoading());
    try {
      final courses = await _courseRepo.getStudentCourses(userId);
      emit(GetMyCoursesSuccess(courses));
    } catch (e) {
      emit(GetMyCoursesFailure(e.toString()));
    }
  }
}
