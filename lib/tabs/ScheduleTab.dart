import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/home/presentation/pages/start_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/styles/colors.dart';
import '../core/styles/styles.dart';

class ScheduleTab extends StatefulWidget {
  final String? doctorId;
  const ScheduleTab({super.key, this.doctorId});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

// enum FilterStatus { Upcoming, Completed, all }

// List<Map> schedules = [
//   {
//     'img':
//         'https://media.licdn.com/dms/image/D4E03AQFaMdhkFrSnBA/profile-displayphoto-shrink_400_400/0/1718284024212?e=1727308800&v=beta&t=Z9P-eejAd2Oc_VbYbgvxUzh35_xNaMqGy-ElgLLMtIc',
//     'doctorName': 'Ayamn mohammed',
//     // 'doctorTitle': 'Dental Specialist',
//     'reservedDate': 'Monday, Aug 29',
//     'reservedTime': '11:00 - 12:00',
//     'status': FilterStatus.Upcoming
//   },
//   {
//     'img':
//         'https://media.licdn.com/dms/image/D4E03AQFaMdhkFrSnBA/profile-displayphoto-shrink_400_400/0/1718284024212?e=1727308800&v=beta&t=Z9P-eejAd2Oc_VbYbgvxUzh35_xNaMqGy-ElgLLMtIc',
//     'doctorName': 'Ayamn mohammed',
//     // 'doctorTitle': 'Dental Specialist',
//     'reservedDate': 'Monday, Aug 29',
//     'reservedTime': '11:00 - 12:00',
//     'status': FilterStatus.Upcoming
//   },
//   {
//     'img':
//         'https://media.licdn.com/dms/image/D4E03AQFaMdhkFrSnBA/profile-displayphoto-shrink_400_400/0/1718284024212?e=1727308800&v=beta&t=Z9P-eejAd2Oc_VbYbgvxUzh35_xNaMqGy-ElgLLMtIc',
//     'doctorName': 'Ayamn mohammed',
//     // 'doctorTitle': 'Dental Specialist',
//     'reservedDate': 'Monday, Aug 29',
//     'reservedTime': '11:00 - 12:00',
//     'status': FilterStatus.Upcoming
//   },
//   {
//     'img':
//         'https://media.licdn.com/dms/image/D4E03AQFaMdhkFrSnBA/profile-displayphoto-shrink_400_400/0/1718284024212?e=1727308800&v=beta&t=Z9P-eejAd2Oc_VbYbgvxUzh35_xNaMqGy-ElgLLMtIc',
//     'doctorName': 'Ayamn mohammed',
//     // 'doctorTitle': 'Dental Specialist',
//     'reservedDate': 'Monday, Aug 29',
//     'reservedTime': '11:00 - 12:00',
//     'status': FilterStatus.Upcoming
//   },
// ];

class _ScheduleTabState extends State<ScheduleTab> {
  // FilterStatus status = FilterStatus.Upcoming;
  Alignment _alignment = Alignment.centerLeft;
  final status = ['القادمه', 'مكتمله', 'اليوم'];

  String currentStatus = 'اليوم';
  int todayTime = DateTime.now().weekday != 7 ? DateTime.now().weekday : 0;
  late bool isAppointmentCompleted;

  @override
  Widget build(BuildContext context) {
    String? doctorId = FirebaseAuth.instance.currentUser?.uid;
    print(doctorId);
    print(DateTime.now().weekday);
    // List<Map> filteredSchedules = schedules.where((var schedule) {
    //   return schedule['status'] == status;
    // }).toList();

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => StartHomePage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'جدول الحجوزات',
              textAlign: TextAlign.center,
              style: kTitleStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(MyColors.bg),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (String status in status)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (status.contains('اليوم')) {
                                  currentStatus = 'اليوم';
                                  _alignment = Alignment.centerLeft;
                                } else if (status.contains('مكتمله')) {
                                  currentStatus = 'مكتمله';
                                  _alignment = Alignment.center;
                                } else if (status.contains('القادمه')) {
                                  currentStatus = 'القادمه';
                                  _alignment = Alignment.centerRight;
                                }
                                print(status +
                                    ": current" +
                                    currentStatus +
                                    ":" +
                                    _alignment.toString());
                              });
                              // setState(() {
                              //   if (filterStatus == FilterStatus.Upcoming) {
                              //     status = FilterStatus.Upcoming;
                              //     _alignment = Alignment.centerLeft;
                              //   } else if (filterStatus ==
                              //       FilterStatus.Complete) {
                              //     status = FilterStatus.Complete;
                              //     _alignment = Alignment.center;
                              //   } else if (filterStatus ==
                              //       FilterStatus.Cancel) {
                              //     status = FilterStatus.Cancel;
                              //     _alignment = Alignment.centerRight;
                              //   }
                              // });
                            },
                            child: Center(
                              child: Text(
                                status,
                                style: kFilterStyle,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  alignment: _alignment,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(MyColors.primary),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        currentStatus,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('doctors')
                        .doc(doctorId)
                        .collection('appointments')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final appointments = snapshot.data!.docs;
                      if (kDebugMode) {
                        print(appointments);
                      }
                      return ListView.builder(
                        itemCount: appointments.length,
                        itemBuilder: (context, index) {
                          final appointment = appointments[index];

                          // var schedule = filteredSchedules[index];
                          // bool isLastElement =
                          //     filteredSchedules.length + 1 == index;
                          if (appointment['appointmentDay'] == todayTime &&
                              currentStatus.contains('اليوم') &&
                              appointment['isCompleted'] != 1) {
                            return Card(
                              // margin: !isLastElement
                              //     ? const EdgeInsets.only(bottom: 20)
                              //     : EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        // CircleAvatar(
                                        //   backgroundImage:
                                        //       // NetworkImage(schedule['img']),
                                        // ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'إسم المريض: ',
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  appointment['patientName'],
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'عمر المريض: ',
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  appointment['patientAge'],
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'رقم الهاتف: ',
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  appointment['patientPhone'],
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            // Text(
                                            //   schedule['doctorTitle'],
                                            //   style: TextStyle(
                                            //     color: Color(MyColors.grey02),
                                            //     fontSize: 12,
                                            //     fontWeight: FontWeight.w600,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    DateTimeCard(
                                      appointmentDay: todayTime,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Expanded(
                                        //   child: OutlinedButton(
                                        //     child: const Text('Cancel'),
                                        //     onPressed: () {},
                                        //   ),
                                        // ),
                                        // const SizedBox(
                                        //   width: 20,
                                        // ),
                                        Expanded(
                                          child: TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                        Colors.green
                                                            .withOpacity(.5)),
                                                textStyle:
                                                    WidgetStateProperty.all(
                                                        const TextStyle(
                                                            color:
                                                                Colors.white))),
                                            child:
                                                const Text('اكتملت المقابله'),
                                            onPressed: () => {
                                              FirebaseFirestore.instance
                                                  .collection('doctors')
                                                  .doc(doctorId)
                                                  .collection('appointments')
                                                  .doc(appointment.id)
                                                  .set(
                                                {
                                                  'appointmentDay': appointment[
                                                      'appointmentDay'],
                                                  'appointmentId': appointment[
                                                      'appointmentId'],
                                                  'patientName': appointment[
                                                      'patientName'],
                                                  'patientAge':
                                                      appointment['patientAge'],
                                                  'patientPhone': appointment[
                                                      'patientPhone'],
                                                  'isCompleted': 1,
                                                },
                                              )
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else if (appointment['isCompleted'] != 1 &&
                              currentStatus.contains('القادمه')) {
                            print('upcoming view');
                            return Card(
                              // margin: !isLastElement
                              //     ? const EdgeInsets.only(bottom: 20)
                              //     : EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        // CircleAvatar(
                                        //   backgroundImage:
                                        //       // NetworkImage(schedule['img']),
                                        // ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'إسم المريض: ',
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  appointment['patientName'],
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'عمر المريض: ',
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  appointment['patientAge'],
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'رقم الهاتف: ',
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  appointment['patientPhone'],
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            // Text(
                                            //   schedule['doctorTitle'],
                                            //   style: TextStyle(
                                            //     color: Color(MyColors.grey02),
                                            //     fontSize: 12,
                                            //     fontWeight: FontWeight.w600,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    DateTimeCard(
                                      appointmentDay:
                                          appointment['appointmentDay'],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Expanded(
                                        //   child: OutlinedButton(
                                        //     child: const Text('Cancel'),
                                        //     onPressed: () {},
                                        //   ),
                                        // ),
                                        // const SizedBox(
                                        //   width: 20,
                                        // ),
                                        Expanded(
                                          child: TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                        Colors.green
                                                            .withOpacity(.5)),
                                                textStyle:
                                                    WidgetStateProperty.all(
                                                        const TextStyle(
                                                            color:
                                                                Colors.white))),
                                            child: const Text(
                                              'اكتملت المقابله',
                                            ),
                                            onPressed: () => {
                                              FirebaseFirestore.instance
                                                  .collection('doctors')
                                                  .doc(doctorId)
                                                  .collection('appointments')
                                                  .doc(appointment.id)
                                                  .set(
                                                {
                                                  'appointmentDay': appointment[
                                                      'appointmentDay'],
                                                  'appointmentId': appointment[
                                                      'appointmentId'],
                                                  'patientName': appointment[
                                                      'patientName'],
                                                  'patientAge':
                                                      appointment['patientAge'],
                                                  'patientPhone': appointment[
                                                      'patientPhone'],
                                                  'isCompleted': 1,
                                                },
                                              )
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else if (appointment['isCompleted'] == 1 &&
                              currentStatus.contains('مكتمله')) {
                            return Card(
                              // margin: !isLastElement
                              //     ? const EdgeInsets.only(bottom: 20)
                              //     : EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        // CircleAvatar(
                                        //   backgroundImage:
                                        //       // NetworkImage(schedule['img']),
                                        // ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'إسم المريض: ',
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  appointment['patientName'],
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'عمر المريض: ',
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  appointment['patientAge'],
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'رقم الهاتف: ',
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  appointment['patientPhone'],
                                                  style: TextStyle(
                                                    color: Color(
                                                        MyColors.header01),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            // Text(
                                            //   schedule['doctorTitle'],
                                            //   style: TextStyle(
                                            //     color: Color(MyColors.grey02),
                                            //     fontSize: 12,
                                            //     fontWeight: FontWeight.w600,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    DateTimeCard(
                                      appointmentDay:
                                          appointment['appointmentDay'],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    })),
          ],
        ),
      ),
    );
  }
}

class DateTimeCard extends StatelessWidget {
  final int appointmentDay;
  const DateTimeCard({
    super.key,
    required this.appointmentDay,
  });

  @override
  Widget build(BuildContext context) {
    final todayTime = DateTime.now().weekday != 7 ? DateTime.now().weekday : 0;
    print(DateTime.now().weekday);
    final List<String> weekDays = [
      'الاحد',
      'الاثنين',
      'الثلاثاء',
      'الاربعاء',
      'الخميس',
      'الجمعه',
      'السبت'
    ];
    final appointmentDay = weekDays[this.appointmentDay];
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg03),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Color(MyColors.primary),
                size: 15,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                todayTime == this.appointmentDay ? "اليوم" : appointmentDay,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Row(
          //   children: [
          //     Icon(
          //       Icons.access_alarm,
          //       color: Color(MyColors.primary),
          //       size: 17,
          //     ),
          //     const SizedBox(
          //       width: 5,
          //     ),
          //     Text(
          //       '11:00 ~ 12:10',
          //       style: TextStyle(
          //         color: Color(MyColors.primary),
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
