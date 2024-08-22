import 'package:course_repository/course_repository.dart';
import '../../../../blocs/get_user_cubit/get_user_cubit.dart';

import '../blocs/get_my_courses_cubit/get_my_courses_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

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
        child: BlocBuilder<GetMyCoursesCubit, GetMyCoursesState>(
          builder: (context, state) {
            if (state is GetMyCoursesSuccess) {
              return CourseGrid(courses: state.courses);
            } else if (state is GetMyCoursesLoading) {
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
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 9 / 16,
      ),
      itemBuilder: (context, index) {
        final course = courses[index];
        return BlocProvider<GetUserCubit>(
          create: (context) =>
              GetUserCubit(FirebaseUserRepo())..getUserById(course.lecturerId),
          child: CourseCard(course: course),
        );
      },
    );
  }
}
