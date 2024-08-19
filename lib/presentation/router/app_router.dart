import 'package:course_repository/course_repository.dart';
import 'package:estu_attendance_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:estu_attendance_app/presentation/features/attendances/blocs/get_attendances_bloc/get_attendances_bloc.dart';
import 'package:estu_attendance_app/presentation/features/course/blocs/get_my_courses_cubit/get_my_courses_cubit.dart';
import 'package:estu_attendance_app/presentation/features/course/views/course_attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/attendances/views/attendance_screen.dart';
import '../features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import '../features/auth/views/welcome_screen.dart';
import '../features/course/views/course_details_screen.dart';
import '../features/course/views/courses_grid_screen.dart';
import '../features/home/views/home_screen.dart';

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
                  create: (context) => GetMyCoursesCubit(FirebaseCourseRepo())
                    ..getMyCourses('1nEQVlUXh4b4xN9CC634yZObzlH2'),
                  // GetCourseBloc(FirebaseCourseRepo())..add(GetCourse()),
                  child: const CoursesGridScreen(),
                ));

      case '/course_details':
        final course = settings.arguments as Course;
        return MaterialPageRoute(
          builder: (_) => CourseDetailsScreen(
            course,
          ),
        );
      case '/attendances_screen':
        final course = settings.arguments as Course;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: context.read<AuthenticationBloc>(),
              ),
              BlocProvider(
                create: (context) =>
                    GetAttendancesBloc(FirebaseAttendanceRepo())
                      ..add(
                        GetAttendances(courseId: course!.courseId),
                      ),
              ),
            ],
            child: AttendancesScreen(
              course: course,
            ),
          ),
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
