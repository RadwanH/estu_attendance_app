import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_repository/course_repository.dart';

class FirebaseCourseRepo implements CourseRepo {
  final courseCollection = FirebaseFirestore.instance.collection('courses');

  @override
  Future<List<Course>> getCourses() async {
    try {
      return await courseCollection.get().then((snapshot) => snapshot.docs
          .map(
              (doc) => Course.fromEntity(CourseEntity.fromDocument(doc.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Course> getCourse(String id) async {
    try {
      return await courseCollection.doc(id).get().then(
          (doc) => Course.fromEntity(CourseEntity.fromDocument(doc.data()!)));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Course> addCourse(Course course) {
    try {
      return courseCollection
          .add(course.toEntity().toDocument())
          .then((doc) => course);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteCourse(String id) {
    try {
      return courseCollection.doc(id).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Course> updateCourse(Course course) {
    try {
      return courseCollection
          .doc(course.courseId)
          .update(course.toEntity().toDocument())
          .then((_) => course);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
