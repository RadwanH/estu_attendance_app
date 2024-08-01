import 'package:course_repository/src/models/models.dart';

import '../entities/entities.dart';

class Course {
  String courseId;
  String name;
  String code;
  String imageUrl;
  int hours;
  String classroom;
  String lecturerId;
  // List<Attendance>? attendances;
  int weeks;

  Course({
    required this.courseId,
    required this.name,
    required this.code,
    required this.imageUrl,
    required this.hours,
    required this.classroom,
    required this.lecturerId,
    // this.attendances,
    this.weeks = 14,
  });

  static final empty = Course(
    courseId: '',
    name: '',
    code: '',
    hours: 0,
    classroom: '',
    lecturerId: '',
    imageUrl: '',
  );

  CourseEntity toEntity() {
    return CourseEntity(
      courseId: courseId,
      name: name,
      code: code,
      imageUrl: imageUrl,
      hours: hours,
      classroom: classroom,
      lecturerId: lecturerId,
      // attendances: attendances,
      weeks: weeks,
    );
  }

  static Course fromEntity(CourseEntity entity) {
    return Course(
      courseId: entity.courseId,
      name: entity.name,
      code: entity.code,
      imageUrl: entity.imageUrl,
      hours: entity.hours,
      classroom: entity.classroom,
      lecturerId: entity.lecturerId,
      // attendances: entity.attendances,
      weeks: entity.weeks,
    );
  }

  @override
  String toString() {
    return 'Course { courseId: $courseId, name: $name, code: $code, imageUrl: $imageUrl, hours: $hours, classroom: $classroom, lecturerId: $lecturerId, attendances: attendances, weeks: $weeks }';
  }
}
