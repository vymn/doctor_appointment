import 'package:doctor_app/appointment/domain/entities/appointment.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

import '../../domain/repository/appointment_repository.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final _firestore = FirebaseFirestore.instance;
  @override
  Future<void> assignNewAppointment({required Appointment appointment}) async {
    try {
      await _firestore
          .collection('appointments')
          .doc(appointment.id)
          .set(appointment.toMap());
    } catch (e) {
      print('Error adding document: $e');
    }
  }

  @override
  Future<List<Appointment>> getAllAppointments() {
    // TODO: implement getAllAppointments
    throw UnimplementedError();
  }

  @override
  Future<Appointment> getAppointmentById({required String appointmentId}) {
    // TODO: implement getAppointmentById
    throw UnimplementedError();
  }
}
