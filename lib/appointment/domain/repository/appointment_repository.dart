import '../entities/appointment.dart';

abstract class AppointmentRepository {
//   assign appointment

  Future<void> assignNewAppointment({required Appointment appointment});

// get all appointments

  Future<List<Appointment>> getAllAppointments();

// get appointment

  Future<Appointment> getAppointmentById({required String appointmentId});
}
