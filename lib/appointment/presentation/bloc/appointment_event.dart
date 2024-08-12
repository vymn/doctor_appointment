part of 'appointment_bloc.dart';

@immutable
sealed class AppointmentEvent {
  const AppointmentEvent();
}

final class GetAllAppointmentsEvent extends AppointmentEvent {}

final class GetAppointmentById extends AppointmentEvent {
  final String appointmentId;

  const GetAppointmentById({required this.appointmentId});
}

final class CreateAppointmentEvent extends AppointmentEvent {
  final Appointment appointment;

  const CreateAppointmentEvent({required this.appointment});
}
