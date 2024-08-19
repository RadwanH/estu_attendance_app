import 'package:course_repository/course_repository.dart';
import 'package:flutter/material.dart';

class CourseAttendanceScreen extends StatelessWidget {
  const CourseAttendanceScreen(
    this.course, {
    super.key,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text('Course Weeks',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              // childAspectRatio: 9 / 16,
            ),
            itemBuilder: (context, index) {
              return Material(
                elevation: 3,
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return CourseDetailsScreen();
                    //     },
                    //   ),
                    // );
                  },
                  child: Center(
                    child: Text(
                      'Week $index',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
