import 'package:flutter/material.dart';

import '../../../home/presentation/pages/HomeTab.dart';
import '../../../core/styles/colors.dart';

class TopDoctorCard extends StatelessWidget {
  String? img;
  String doctorName;
  String doctorTitle;
  final void Function() onTap;

  TopDoctorCard({
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
                    // CircleAvatar(
                    //     backgroundImage: img != null
                    //         ? NetworkImage(img!)
                    //         : const AssetImage('assets/images/doctor.png')),
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
    // return Card(
    //   color: Colors.white,
    //   elevation: 0.1,
    //   margin: const EdgeInsets.only(bottom: 20),
    //   child: InkWell(
    //     onTap: onTap,
    //     child: Row(
    //       children: [
    //         CircleAvatar(
    //           radius: 30,
    //           backgroundImage: img != null
    //               ? NetworkImage(img!)
    //               : AssetImage('assets/images/doctor.png'),
    //         ),
    //         // Container(
    //         //     height: 100,
    //         //     decoration: BoxDecoration(
    //         //         color: Color(MyColors.grey01),
    //         //         borderRadius: BorderRadius.circular(12)),
    //         //     child: img != null
    //         //         ? Image(
    //         //             width: 100,
    //         //             image: NetworkImage(img!),
    //         //           )
    //         //         : null),
    //         const SizedBox(
    //           width: 10,
    //         ),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text(
    //               doctorName,
    //               style: TextStyle(
    //                   color: Color(MyColors.header01),
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: 18),
    //             ),
    //             const SizedBox(
    //               height: 5,
    //             ),
    //             Text(
    //               doctorTitle,
    //               style: TextStyle(
    //                 color: Color(MyColors.grey02),
    //                 fontSize: 12,
    //                 fontWeight: FontWeight.w600,
    //               ),
    //             ),
    //             const SizedBox(
    //               height: 30,
    //             ),
    //             Divider(
    //               height: 5,
    //               thickness: 2,
    //               color: Color(MyColors.grey02),
    //             ),
    //             TextButton(onPressed: () {}, child: Text('Make an appointment'))
    //             // Row(
    //             //   crossAxisAlignment: CrossAxisAlignment.center,
    //             //   children: [
    //             //     Icon(
    //             //       Icons.star,
    //             //       color: Color(MyColors.yellow02),
    //             //       size: 18,
    //             //     ),
    //             //     const SizedBox(
    //             //       width: 5,
    //             //     ),
    //             //     // Text(
    //             //     //   '4.0 - 50 Reviews',
    //             //     //   style: TextStyle(color: Color(MyColors.grey02)),
    //             //     // )
    //             //   ],
    //             // )
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
