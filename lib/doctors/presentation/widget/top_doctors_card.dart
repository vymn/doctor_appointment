import 'package:flutter/material.dart';

import '../../../home/presentation/pages/home.dart';
import '../../../core/styles/colors.dart';
import '../../../home/presentation/widgets/schedule_card.dart';

class TopDoctorCard extends StatelessWidget {
  final String? img;
  final String doctorName;
  final String doctorTitle;
  final void Function() onTap;

  const TopDoctorCard({
    super.key,
    required this.img,
    required this.doctorName,
    required this.doctorTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Color(MyColors.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doctorName,
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          doctorTitle,
                          style: TextStyle(color: Color(MyColors.text01)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const ScheduleCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
