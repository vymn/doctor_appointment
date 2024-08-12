import 'package:doctor_app/doctors/presentation/bloc/doctors_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/doctor.dart';
import '../widget/top_doctors_card.dart';
import 'doctor_detail.dart';

class DoctorsScreen extends StatelessWidget {
  final List<Doctor> doctors;
  const DoctorsScreen({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 320,
      child: ListView.builder(
        itemCount: doctors.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return TopDoctorCard(
            img: doctors[index].image,
            doctorName: doctors[index].name,
            doctorTitle: doctors[index].specialty,
            onTap: () {
              context.read<DoctorsBloc>().add(GetDoctorById(doctors[index].id));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          SliverDoctorDetail(doctor: doctors[index])));
            },
          );
        },
      ),
    );
  }
}
