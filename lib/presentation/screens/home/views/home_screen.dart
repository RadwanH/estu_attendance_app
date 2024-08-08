import 'dart:ui';

import 'package:course_repository/course_repository.dart';
import 'package:estu_attendance_app/components/my_main_container_card.dart';
import 'package:estu_attendance_app/presentation/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:estu_attendance_app/presentation/screens/auth/views/welcome_screen.dart';
import 'package:estu_attendance_app/presentation/screens/course/blocs/get_course_bloc/get_course_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../components/section_title.dart';
import '../../../../constants/constants.dart';
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: defaultPadding * 2),
                MyMainContainerCard(
                  title: 'Discover Your Courses',
                  onTap: () {
                    print('Discover Your Courses clicked');
                    Navigator.of(context).pushNamed('/courses');
                  },
                ),
                const SizedBox(height: defaultPadding * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
