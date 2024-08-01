import 'models/models.dart';

abstract class CourseRepo {
  Future<List<Course>> getCourses();
  Future<Course> getCourse(String id);
  Future<Course> addCourse(Course course);
  Future<Course> updateCourse(Course course);
  Future<void> deleteCourse(String id);
}
