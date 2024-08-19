import 'package:course_repository/course_repository.dart';
import 'package:estu_attendance_app/presentation/router/app_router.dart';
import 'package:estu_attendance_app/presentation/features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';

import 'package:estu_attendance_app/presentation/features/course/views/courses_grid_screen.dart';
import 'package:estu_attendance_app/presentation/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'presentation/features/auth/views/welcome_screen.dart';
import 'presentation/features/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  final AppRouter appRouter;
  const MyAppView({super.key, required this.appRouter});

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
            onPrimary: Colors.white),
      ),
      onGenerateRoute: appRouter.onGenerateRoute,
    );
  }
}
