part of 'appointment_bloc.dart';

@immutable
sealed class AppointmentState {
  const AppointmentState();
}

final class AppointmentInitial extends AppointmentState {}

final class AppointmentsLoading extends AppointmentState {}

final class AppointmentsLoaded extends AppointmentState {
  final List<Appointment> appointments;

  const AppointmentsLoaded({required this.appointments});
}

final class AppointmentLoaded extends AppointmentState {
  final Appointment appointment;

  const AppointmentLoaded({required this.appointment});
}
