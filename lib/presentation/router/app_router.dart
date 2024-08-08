import 'package:course_repository/course_repository.dart';
import 'package:estu_attendance_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:estu_attendance_app/presentation/screens/course/views/course_attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import '../screens/auth/views/welcome_screen.dart';
import '../screens/course/blocs/get_course_bloc/get_course_bloc.dart';
import '../screens/course/views/course_details_screen.dart';
import '../screens/course/views/courses_grid_screen.dart';
import '../screens/home/views/home_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state.status == AuthenticationStatus.authenticated) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => SignInBloc(
                          context.read<AuthenticationBloc>().userRepository),
                    ),
                    // BlocProvider(
                    //   create: (context) => GetCourseBloc(FirebaseCourseRepo())
                    //     ..add(
                    //       GetCourse(),
                    //     ),
                    // )
                  ],
                  child: const HomeScreen(),
                );
              } else {
                return const WelcomeScreen();
              }
            },
          ),
        );
      case '/courses':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>
                      GetCourseBloc(FirebaseCourseRepo())..add(GetCourse()),
                  child: const CoursesGridScreen(),
                ));

      case '/course_details':
        final course = settings.arguments as Course;
        return MaterialPageRoute(
          builder: (_) => CourseDetailsScreen(
            course,
          ),
        );
      case '/course_attendance_screen':
        final course = settings.arguments as Course;
        return MaterialPageRoute(
          builder: (_) => CourseAttendanceScreen(course),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
