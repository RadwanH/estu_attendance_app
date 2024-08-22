import 'dart:ui';

import 'package:course_repository/course_repository.dart';
import 'package:estu_attendance_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:estu_attendance_app/components/my_main_container_card.dart';
import 'package:estu_attendance_app/presentation/features/attendances/blocs/current_attendance_cubit/current_attendance_cubit.dart';
import 'package:estu_attendance_app/presentation/features/attendances/views/active_attendanceOLD.dart';
import 'package:estu_attendance_app/presentation/features/attendances/views/active_attendance_screen.dart';
import 'package:estu_attendance_app/presentation/features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:estu_attendance_app/presentation/features/auth/views/welcome_screen.dart';
import 'package:estu_attendance_app/presentation/features/course/blocs/get_my_courses_cubit/get_my_courses_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../components/section_title.dart';
import '../../../../constants/constants.dart';
import '../../attendances/blocs/active_attendances_cubit/active_attendances_cubit.dart';
import '../../attendances/views/active_attendance.dart';
import '../../course/views/course_details_screen.dart';
import '../../course/views/courses_grid_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: const EdgeInsets.all(0),
                  collapseMode: CollapseMode.parallax,
                  title: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/estu_logo.png',
                          scale: 13,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Attendance App',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 27,
                          ),
                        ),
                      ],
                    ),
                  ),
                  background: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                    child: Image.network(
                      "https://www.eskisehir.edu.tr/Uploads/www/Icerik/Buyuk/154d41bc-770a-4061-8b55-339ff30c8efb-5bd9cbc435d98.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const FaIcon(FontAwesomeIcons.rightFromBracket),
                        onPressed: () {
                          context.read<SignInBloc>().add(SignOutRequired());
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ];
          },
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<GetMyCoursesCubit>().getMyCourses(
                    context.read<AuthenticationBloc>().state.user!.userId,
                  );
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: defaultPadding * 2),
                  MyMainContainerCard(
                    title: 'Discover Your Courses',
                    onTap: () {
                      Navigator.of(context).pushNamed('/courses');
                    },
                  ),
                  const SizedBox(height: defaultPadding * 2),
                  BlocBuilder<GetMyCoursesCubit, GetMyCoursesState>(
                    builder: (context, state) {
                      if (state is GetMyCoursesLoading) {
                        return Center(
                          child: Text(
                            'Loading...',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        );
                      } else if (state is GetMyCoursesSuccess) {
                        final courseIds = state.courses
                            .map((course) => course.courseId)
                            .toList();

                        return BlocProvider(
                          create: (context) => ActiveAttendancesCubit(
                            FirebaseAttendanceRepo(),
                          )..getActiveAttendances(courseIds),
                          child: ActiveAttendance(
                            courses: state.courses,
                          ),
                        );
                      } else if (state is GetMyCoursesFailure) {
                        return const Text('Failed to load courses');
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(height: defaultPadding * 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
