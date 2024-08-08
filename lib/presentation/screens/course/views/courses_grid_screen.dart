import 'package:course_repository/course_repository.dart';
import 'package:estu_attendance_app/presentation/screens/course/blocs/get_course_bloc/get_course_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'course_card.dart';
import 'course_details_screen.dart';

class CoursesGridScreen extends StatelessWidget {
  const CoursesGridScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text('All Courses',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<GetCourseBloc, GetCourseState>(
          builder: (context, state) {
            if (state is GetCourseSuccess) {
              return CourseGrid(courses: state.courses);
            } else if (state is GetCourseLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text('An error has occurred while loading courses...'),
              );
            }
          },
        ),
      ),
    );
  }
}

class CourseGrid extends StatelessWidget {
  final List<Course> courses;
  const CourseGrid({
    super.key,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: courses.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 9 / 16,
      ),
      itemBuilder: (context, index) {
        final course = courses[index];
        return CourseCard(course: course);
      },
    );
  }
}
