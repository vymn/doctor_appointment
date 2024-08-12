import 'package:doctor_app/clinics/presentation/clinic_bloc.dart';
import 'package:doctor_app/doctors/presentation/bloc/doctors_bloc.dart';
import 'package:doctor_app/doctors/presentation/pages/doctors_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/styles/colors.dart';

List<Map> doctors = [
  {
    'img':
        'https://media.licdn.com/dms/image/D4E03AQFaMdhkFrSnBA/profile-displayphoto-shrink_400_400/0/1718284024212?e=1727308800&v=beta&t=Z9P-eejAd2Oc_VbYbgvxUzh35_xNaMqGy-ElgLLMtIc',
    'doctorName': 'Dr. Ayman Mohammed',
    'doctorTitle': 'Heart Specialist'
  },
  {
    'img':
        'https://media.licdn.com/dms/image/D4E03AQFaMdhkFrSnBA/profile-displayphoto-shrink_400_400/0/1718284024212?e=1727308800&v=beta&t=Z9P-eejAd2Oc_VbYbgvxUzh35_xNaMqGy-ElgLLMtIc',
    'doctorName': 'Dr. Ayman Mohammed',
    'doctorTitle': 'Heart Specialist'
  },
  {
    'img':
        'https://media.licdn.com/dms/image/D4E03AQFaMdhkFrSnBA/profile-displayphoto-shrink_400_400/0/1718284024212?e=1727308800&v=beta&t=Z9P-eejAd2Oc_VbYbgvxUzh35_xNaMqGy-ElgLLMtIc',
    'doctorName': 'Dr. Ayman Mohammed',
    'doctorTitle': 'Heart Specialist'
  },
];

class HomeTab extends StatelessWidget {
  final void Function() onPressedScheduleCard;

  const HomeTab({
    super.key,
    required this.onPressedScheduleCard,
  });

  @override
  Widget build(BuildContext context) {
    late String _clinicName;
    context.read<ClinicBloc>().add(const GetClinicsEvent());
    context.read<DoctorsBloc>().add(const GetAllDoctorsEvent());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            const UserIntro(),
            const SizedBox(
              height: 10,
            ),
            const ClinicsIcons(),
            const SizedBox(
              height: 20,
            ),
            // const SearchInput(),
            const SizedBox(
              height: 20,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Appointment Today',
            //       style: kTitleStyle,
            //     ),
            //     TextButton(
            //       child: Text(
            //         'See All',
            //         style: TextStyle(
            //           color: Color(MyColors.yellow01),
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       onPressed: () {},
            //     )
            //   ],
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // AppointmentCard(
            //   onTap: onPressedScheduleCard,
            // ),

            const SizedBox(
              height: 40,
            ),
            Text(
              'أميز الاطباء',
              style: TextStyle(
                  color: Color(MyColors.header01),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<DoctorsBloc, DoctorsState>(
              builder: (context, state) {
                if (state is DoctorsLoading || state is DoctorsInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is DoctorsLoaded) {
                  if (state.doctors == null || state.doctors.length == 0)
                    return const Center(
                      child: Text(
                          'لا يوجد اطباء في هذه العياده الرجاء اختيار عياده اخري'),
                    );

                  return DoctorsScreen(doctors: state.doctors);
                }
                return const SizedBox(

                    // child: Expanded(
                    //   child: ListView(
                    //     children: [
                    //       Text(
                    //         'أميز الاطباء',
                    //         style: TextStyle(
                    //             color: Color(MyColors.header01),
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 16),
                    //       ),
                    //       const SizedBox(
                    //         height: 20,
                    //       ),
                    //       for (var doctor in doctors)
                    //         TopDoctorCard(
                    //           img: doctor['img'],
                    //           doctorName: doctor['doctorName'],
                    //           doctorTitle: doctor['doctorTitle'],
                    //         ),
                    //     ],
                    //   ),
                    // ),
                    );
              },
              listener: (BuildContext context, DoctorsState state) {
                if (state is DoctorsInitial) {
                  context.read<DoctorsBloc>().add(const GetAllDoctorsEvent());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final void Function() onTap;

  const AppointmentCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
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
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/doctor01.jpeg'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Dr.Muhammed Syahid',
                                style: TextStyle(color: Colors.white)),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Dental Specialist',
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
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.bg02),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.bg03),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

// List<Map> categories = [
//   {'icon': Icons.coronavirus, 'text': 'الاطفال'},
//   {'icon': Icons.local_hospital, 'text': 'محجر العين'},
//   {'icon': Icons.car_rental, 'text': 'الحول'},
//   {'icon': Icons.local_pharmacy, 'text': 'الجلاكوما'},
//   {'icon': Icons.local_pharmacy, 'text': 'الشبكية'},
//   {'icon': Icons.local_pharmacy, 'text': 'القرنية'},
// ];

class ClinicsIcons extends StatelessWidget {
  // final List<Clinic> clinics;
  const ClinicsIcons({
    super.key,
    // required this.clinics,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .9;
    return BlocBuilder<ClinicBloc, ClinicState>(builder: (context, state) {
      if (state is ClinicLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ClinicLoaded) {
        return SizedBox(
          width: width,
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var clinic in state.clinics)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: CategoryIcon(
                    id: clinic.id,
                    icon: Icons.local_pharmacy,
                    text: clinic.name,
                  ),
                )
            ],
          ),
        );
      } else {
        return const Center(
          child: Text('there is no clinics available'),
        );
      }
    });
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg01),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'احجز موعد',
            style: TextStyle(color: Colors.white),
          ),
          // SizedBox(
          //   width: 20,
          // ),
          // Icon(
          //   Icons.access_alarm,
          //   color: Colors.white,
          //   size: 17,
          // ),
          // SizedBox(
          //   width: 5,
          // ),
          // Flexible(
          //   child: Text(
          //     '11:00 ~ 12:10',
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  IconData icon;
  String text;
  final String id;

  CategoryIcon({
    super.key,
    required this.icon,
    required this.text,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Color(MyColors.bg01),
      onTap: () {
        context.read<DoctorsBloc>().add(GetDoctorsByClinicId(clinicId: id));
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Color(MyColors.bg),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                color: Color(MyColors.primary),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(
                color: Color(MyColors.primary),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(MyColors.bg),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Icon(
              Icons.search,
              color: Color(MyColors.purple02),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'أبحث عن طبيب ...',
                hintStyle: TextStyle(
                    fontSize: 13,
                    color: Color(MyColors.purple01),
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserIntro extends StatelessWidget {
  const UserIntro({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مستشفي',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              'مكه للعيون',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        // CircleAvatar(
        //   backgroundImage: AssetImage('assets/person.jpeg'),
        // )
      ],
    );
  }
}
