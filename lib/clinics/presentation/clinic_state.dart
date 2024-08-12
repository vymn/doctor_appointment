part of 'clinic_bloc.dart';

@immutable
sealed class ClinicState {}

final class ClinicInitial extends ClinicState {}

final class ClinicLoading extends ClinicState {}

final class ClinicLoaded extends ClinicState {
  final List<Clinic> clinics;

  ClinicLoaded({required this.clinics});
}

final class ClinicDoctorLaoding extends ClinicState {}

final class ClinicsDoctorsLoaded extends ClinicState {
  final List<Doctor> doctors;
  ClinicsDoctorsLoaded({required this.doctors});
}
