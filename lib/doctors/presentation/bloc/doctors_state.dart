part of 'doctors_bloc.dart';

@immutable
sealed class DoctorsState {
  const DoctorsState();
}

final class DoctorsInitial extends DoctorsState {}

class DoctorsLoading extends DoctorsState {}

class DoctorsLoaded extends DoctorsState {
  final List<Doctor> doctors;
  const DoctorsLoaded({required this.doctors});
}

class DoctorLoading extends DoctorsState {}

class DoctorLoaded extends DoctorsState {
  final Doctor doctor;
  const DoctorLoaded({required this.doctor});
}
