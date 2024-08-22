import 'package:course_repository/course_repository.dart';
import 'package:flutter/material.dart';

import 'components/atttendance_card.dart';

class AttendancesGrid extends StatelessWidget {
  final List<Attendance> attendances;
  final String currentUserId;

  const AttendancesGrid({
    super.key,
    required this.attendances,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: attendances.isNotEmpty
                    ? Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: attendances
                            .map(
                              (attendance) => ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width / 2 -
                                          32,
                                ),
                                child: AttendanceCard(
                                  attendance: attendance,
                                  color: attendance.attendeesIds!
                                          .contains(currentUserId)
                                      ? Colors.greenAccent
                                      : Colors
                                          .redAccent, // Determine the color based on attendeesIds
                                ),
                              ),
                            )
                            .toList(),
                      )
                    : const Center(
                        child: Text('No Attendances found...'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
