import 'package:estu_attendance_app/components/my_round_button.dart';
import 'package:estu_attendance_app/constants/app_assets.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class MyMainContainerCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const MyMainContainerCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 240, // Set to a height that makes sense for your design
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                bottom: 5, top: 30), // Replace bottom positioning
            child: Align(
              alignment:
                  Alignment.bottomCenter, // Replace left and right positioning
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 20,
                          color: AppColors.kGreyColor.withOpacity(0.7)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      MyRoundButton(
                        onTap: onTap,
                        title: "View Courses",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            height: 100,
            width: 100,

            top: 5,
            right: 5,
            // Replace bottom and right positioning
            child: ClipRRect(
              child: Container(
                decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(255, 203, 203, 203).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Image.asset(
                  AppAssets.kEstuLogo,
                  fit: BoxFit.cover,
                  height: 250,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
