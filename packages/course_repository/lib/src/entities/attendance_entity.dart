import 'package:user_repository/user_repository.dart';

class AttendanceEntity {
  final String id;
  final String lecturerId;
  final String courseId;
  final int week;
  final DateTime? date;
  final int timer;
  final String generatedCode;
  final List<MyUser> attendees;

  AttendanceEntity({
    required this.id,
    required this.lecturerId,
    required this.courseId,
    required this.week,
    DateTime? date,
    required this.timer,
    required this.generatedCode,
    required this.attendees,
  }) : this.date = date ?? DateTime.now();

  static final empty = AttendanceEntity(
    id: '',
    lecturerId: '',
    courseId: '',
    week: 0,
    date: DateTime.now(),
    timer: 0,
    generatedCode: '',
    attendees: [],
  );

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'lecturerId': lecturerId,
      'courseId': courseId,
      'week': week,
      'date': date,
      'timer': timer,
      'generatedCode': generatedCode,
      'attendees': attendees.map((e) => e.toEntity()).toList(),
    };
  }

  static AttendanceEntity fromDocument(Map<String, Object?> doc) {
    return AttendanceEntity(
      id: doc['id'] as String,
      lecturerId: doc['lecturerId'] as String,
      courseId: doc['courseId'] as String,
      week: doc['week'] as int,
      date: doc['date'] as DateTime,
      timer: doc['timer'] as int,
      generatedCode: doc['generatedCode'] as String,
      attendees:
          (doc['attendees'] as List).map((e) => MyUser.fromEntity(e)).toList(),
    );
  }
}
