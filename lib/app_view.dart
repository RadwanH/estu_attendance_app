import 'package:course_repository/course_repository.dart';
import 'package:estu_attendance_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:estu_attendance_app/screens/course/blocs/get_course_bloc/get_course_bloc.dart';
import 'package:estu_attendance_app/screens/course/views/courses_grid_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'screens/auth/views/welcome_screen.dart';
import 'screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Estu Attendance App',
      theme: ThemeData(
          colorScheme: ColorScheme.light(
              surface: Colors.grey.shade200,
              onSurface: Colors.black,
              primary: Colors.blue,
              onPrimary: Colors.white)),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignInBloc(
                      context.read<AuthenticationBloc>().userRepository),
                ),
                BlocProvider(
                  create: (context) => GetCourseBloc(FirebaseCourseRepo())
                    ..add(
                      GetCourse(),
                    ),
                ),
              ],
              child: const CoursesGridScreen(),
            );
          } else {
            return WelcomeScreen();
          }
        },
      ),
    );
  }
}
