import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'doctor_details.dart';

class ClinicDetailsScreen extends StatelessWidget {
  final String clinicId;

  const ClinicDetailsScreen({super.key, required this.clinicId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('clinics')
            .doc(clinicId)
            .collection('doctors')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final doctors = snapshot.data!.docs;

          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              print(doctor.id);
              return ListTile(
                title: Text(doctor['name']),
                subtitle: Text(doctor['specialization']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorDetailsScreen(
                        doctorId: doctor.id,
                        doctor: doctor,
                        clinicId: clinicId,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
