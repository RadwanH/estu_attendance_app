import 'package:course_repository/course_repository.dart';
import '../blocs/get_attendances_bloc/get_attendances_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'attendances_grid.dart';

class AttendancesScreen extends StatelessWidget {
  final Course? course;
  const AttendancesScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text('Attendances',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:
                          BlocBuilder<GetAttendancesBloc, GetAttendancesState>(
                        builder: (context, state) {
                          if (state is GetAttendancesSuccess) {
                            if (state.attendances.isEmpty) {
                              return const Center(
                                child: Text('No Attendances found...'),
                              );
                            }
                            return AttendancesGrid(
                                attendances: state.attendances);
                          } else if (state is GetAttendancesLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is GetAttendancesFailure) {
                            return Center(
                              child: Text('Error: ${state.message}'),
                            );
                          } else {
                            return const Center(
                              child: Text(
                                  'An error has occurred while loading attendances...'),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
