import 'package:doctor_app/clinics/domain/entities/clinic.dart';
import 'package:doctor_app/clinics/domain/repository/clinic_repository.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class ClinicRepositoryImpl implements ClinicRepository {
  @override
  Future<List<Clinic>> getClinics() async {
    final snapshots =
        await FirebaseFirestore.instance.collection('clinics').get();
    return snapshots.docs
        .map((doc) => Clinic(
              name: doc.data()['name'] as String,
              // imageUrl: doc.data()['imageUrl'] as String,
              doctors: const [],
              id: doc.id,
            ))
        .toList();
  }
}
