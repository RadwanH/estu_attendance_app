import 'package:course_repository/src/entities/entities.dart';
import 'package:course_repository/src/models/models.dart';

class CourseEntity {
  final String courseId;
  final String name;
  final String code;
  final String imageUrl;
  final int hours;
  final String classroom;
  final String lecturerId;
  // final List<Attendance>? attendances;
  final int weeks;

  CourseEntity({
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

  static final empty = CourseEntity(
    courseId: '',
    name: '',
    code: '',
    hours: 0,
    classroom: '',
    lecturerId: '',
    imageUrl: '',
  );

  Map<String, Object?> toDocument() {
    return {
      'courseId': courseId,
      'name': name,
      'code': code,
      'imageUrl': imageUrl,
      'hours': hours,
      'classroom': classroom,
      'lecturerId': lecturerId,
      // 'attendances': attendances?.map((e) => e.toEntity()).toList(),
      'weeks': weeks,
    };
  }

  static CourseEntity fromDocument(Map<String, Object?> doc) {
    return CourseEntity(
      courseId: doc['courseId'] as String,
      name: doc['name'] as String,
      code: doc['code'] as String,
      imageUrl: doc['imageUrl'] as String,
      hours: doc['hours'] as int,
      classroom: doc['classroom'] as String,
      lecturerId: doc['lecturerId'] as String,
      // attendances: (doc['attendances'] as List?)
      //     ?.map((e) => Attendance.fromEntity(
      //         AttendanceEntity.fromDocument(e as Map<String, Object?>)))
      //     .toList(),
      weeks: doc['weeks'] as int,
    );
  }
}
