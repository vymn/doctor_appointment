import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'clinic_details.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clinics'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('clinics').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final clinics = snapshot.data!.docs;
          return ListView.builder(
            itemCount: clinics.length,
            itemBuilder: (context, index) {
              final clinic = clinics[index];
              return ListTile(
                title: Text(clinic['name']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ClinicDetailsScreen(clinicId: clinic.id),
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
